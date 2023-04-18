provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "douglab"
  location = "westeurope"
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "vmlinux-azure-douglab"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = []
  vm_size               = "Standard_B1s"

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_4"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "vmlinux-azure-douglab"
    admin_username = "douglas"
    admin_password = "Linux@Azure2023!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-vmlinux-azure-douglab"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = "/subscriptions/c8d447e9-5715-456b-8b81-cdef4232c14f/resourceGroups/douglab/providers/Microsoft.Network/virtualNetworks/vnet-douglab/subnets/subnet-douglab"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = "public-ip-vmlinux-azure-douglab"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Dynamic"
}

resource "azurerm_network_interface_public_ip_attachment" "nic_public_ip" {
  name            = "nic-public-ip-vmlinux-azure-douglab"
  network_interface_id = azurerm_network_interface.nic.id
  public_ip_address_id = azurerm_public_ip.public_ip.id
}

resource "azurerm_managed_disk" "osdisk" {
  name                 = "osdisk-vmlinux-azure-douglab"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "FromImage"
  image_reference_id   = azurerm_virtual_machine.vm.storage_image_reference_id
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk" {
  managed_disk_id    = azurerm_managed_disk.osdisk.id
  virtual_machine_id = azurerm_virtual_machine.vm.id
  lun                = 0
  caching            = "ReadWrite"
  disk_size_gb       = 32
}

resource "azurerm_virtual_machine_extension" "vm_extension" {
  name                 = "customScript"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_machine_id   = azurerm_virtual_machine.vm

