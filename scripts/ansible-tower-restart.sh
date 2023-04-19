#!/bin/bash

# Stop the Ansible Tower services
ansible-tower-service stop

# Wait for the services to stop
sleep 10

# Start the Ansible Tower services
ansible-tower-service start

