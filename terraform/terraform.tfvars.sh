#!/bin/bash

# Azure credentials
ARM_SUBSCRIPTION_ID=""
ARM_CLIENT_ID=""
ARM_CLIENT_SECRET=""
ARM_TENANT_ID=""

# Resource group settings
RESOURCE_GROUP_NAME="douglab"
RESOURCE_GROUP_LOCATION="westeurope"

# Virtual network settings
VIRTUAL_NETWORK_NAME="my-virtual-network"
VIRTUAL_NETWORK_ADDRESS_SPACE="10.0.0.0/16"

# Create the terraform.tfvars file
cat > terraform.tfvars <<EOF
subscription_id = "$ARM_SUBSCRIPTION_ID"
client_id       = "$ARM_CLIENT_ID"
client_secret   = "$ARM_CLIENT_SECRET"
tenant_id       = "$ARM_TENANT_ID"

resource_group_name    = "$RESOURCE_GROUP_NAME"
resource_group_location = "$RESOURCE_GROUP_LOCATION"

virtual_network_name        = "$VIRTUAL_NETWORK_NAME"
virtual_network_address_space = "$VIRTUAL_NETWORK_ADDRESS_SPACE"
EOF

# Initialize Terraform
terraform init

# Plan Terraform changes
terraform plan

# Apply Terraform changes
terraform apply

