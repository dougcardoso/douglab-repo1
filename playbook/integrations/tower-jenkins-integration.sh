#!/bin/bash

# Set variables for Ansible Tower and Jenkins hostnames
ansible_tower_host="ansible.douglab"
jenkins_host="server1.douglab"

# Generate Ansible Tower API token
echo "Enter Ansible Tower username:"
read username
echo "Enter Ansible Tower password:"
read -s password
api_token=$(curl -X POST -s -H "Content-Type: application/json" -d '{"username":"'$username'","password":"'$password'"}' https://'$ansible_tower_host'/api/v2/token/ | jq -r '.token')

# Configure Jenkins to use Ansible Tower as an inventory source
curl -X POST -s -H "Authorization: Bearer $api_token" -H "Content-Type: application/json" -d '{"name": "Ansible Tower", "source": "tower", "tower_host": "'$ansible_tower_host'", "tower_username": "'$username'", "tower_password": "'$password'"}' https://'$ansible_tower_host'/api/v2/inventory_sources/

# Add Ansible Tower credentials to Jenkins
curl -X POST -s -H "Authorization: Bearer $api_token" -H "Content-Type: application/json" -d '{"name": "Ansible Tower Credentials", "credential_type": "Machine", "inputs": [{"id": "username", "value": "'$username'"}, {"id": "password", "value": "'$password'"}]}' https://'$ansible_tower_host'/api/v2/credentials/

# Configure Jenkins job to use Ansible Tower playbook
curl -X POST -s -H "Authorization: Bearer $api_token" -H "Content-Type: application/json" -d '{"name": "Ansible Tower Job", "project": "Default", "playbook": "example_playbook.yml", "inventory": "Ansible Tower", "credential": "Ansible Tower Credentials", "limit": "all", "verbosity": 0, "extra_vars": ""}' http://'$jenkins_host'/job/My%20Job/config.xml

