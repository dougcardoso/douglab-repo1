#!/bin/bash

# Azure credentials
ARM_SUBSCRIPTION_ID="c8d447e9-5715-456b-8b81-cdef4232c14f"
ARM_CLIENT_ID="c5808176-fdc0-49f9-bc8e-62e9503e1276"
ARM_CLIENT_SECRET="c0549013-04d5-4f80-9fbe-33bc4b0aeeeb"
ARM_TENANT_ID="01e0b666-f683-4582-a14d-6dd0d9a63f63"

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

