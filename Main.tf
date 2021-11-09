terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.83.0"
    }
  }
}
provider "azurerm" {
    features {}
    subscription_id = "${var.subscription_id}"
    tenant_id       = "${var.tenant_id}"
}
# NETWORK INTERFACE

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}"
  location = "eastus"
}

resource "azurerm_virtual_network" "example" {
  name                = "${var.name_virtual_network}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "ID" {
  name                 = "${var.name_subnet}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_network_interface" "mgr-nic" {
  name                      = "nic-${var.name_virtual_network}"
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name  
  

  ip_configuration {
    name                          = "nic-${var.network_interface_ids}"
    subnet_id                     = azurerm_subnet.ID.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.mgr.id
  }
}

# NSG
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.name_virtual_machine}-NSG"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH-Inbound"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    access                     = "Allow"
    priority                   = 100
    direction                  = "Inbound"
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.mgr-nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_public_ip" "mgr" {
  name                = "${var.name_pubic_ip}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"

  tags = {
    Resource = "public_ip"
  }
}

resource "azurerm_marketplace_agreement" "cognosys" {
  publisher = "cognosys"
  offer     = "docker-ce-with-centos-8-0-free"
  plan      = "cognosys"
} 

# VIRTUAL MACHINE
resource "azurerm_linux_virtual_machine" "vm-linux" {
  name                = var.name_virtual_machine
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_D2s_v3"
  network_interface_ids = [azurerm_network_interface.mgr-nic.id]
  computer_name  = var.name_virtual_machine
  admin_username = var.admin_username
  admin_password = var.admin_password
  disable_password_authentication = false
  # IMAGEM S.O
  source_image_reference {
    publisher = "cognosys"
    offer     = "docker-ce-with-centos-8-0-free"
    sku       = "docker-ce-with-centos-8-0-free"
    version   = "latest"
  } 

  plan {
    name      = "docker-ce-with-centos-8-0-free"
    publisher = "cognosys"
    product   = "docker-ce-with-centos-8-0-free"
  }


  # DISCO S.O
  os_disk {
    name                 = "${var.name_virtual_machine}_DataDisk_S.O"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 64
  }
}



