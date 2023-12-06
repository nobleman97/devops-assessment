module "network" {
  source = "./modules/network"

}


module "app-vm" {
  source = "./modules/machines"

  vm_map = {
    
    # app = {
    #   name           = "web"
    #   location       = "eastus2"
    #   size           = "Standard_B1s"
    #   admin_username = "saitama"
    #   nic = [ azurerm_network_interface.public.id ]
    #   admin_ssh_key = {
    #     username   = "saitama"
    #     public_key = "~/.ssh/assessment.pub"
    #   }
    # },

    mysql = {
      name           = "postgres"
      location       = "eastus2"
      size           = "Standard_B1s"
      admin_username = "saitama"
      nic = [ azurerm_network_interface.private.id  ]
      admin_ssh_key = {
        username   = "saitama"
        public_key = "~/.ssh/assessment.pub"
      }
    }
  }
}




# resource "azurerm_public_ip" "this" {
#   name                = "app-public-ip"
#   resource_group_name = data.azurerm_resource_group.this.name
#   location            = data.azurerm_resource_group.this.location
#   allocation_method   = "Dynamic"
# }


locals {

  subnets = {
    app = "subnet1_eastus2"
    db = "subnet2_eastus2"
    sp-sub = "subnet3_eastus2"
  }
}

# resource "azurerm_network_interface" "public" {
#   name                = "public-nic"
#   location            = var.location
#   resource_group_name = data.azurerm_resource_group.this.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = module.network.pub-subnets["${local.subnets.app}"]
#     private_ip_address_allocation = "Dynamic"
#   }

#   ip_configuration {
#     name                          = "public"
#     subnet_id                     = module.network.pub-subnets["${local.subnets.app}"]
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.this.id
#     primary = true
#   }

# }

resource "azurerm_network_interface" "private" {

  name                = "private-nic"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.this.name

  ip_configuration {
    name                          = "private"
    subnet_id                     = module.network.priv-subnets["${local.subnets.db}"]
    private_ip_address_allocation = "Dynamic"
    primary = true
  }

}


resource "azurerm_network_security_group" "this" {
  name                = "mysql-sg"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name


  security_rule {
    name                       = "Allow_SSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_443"
    priority                   = 2000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow_5432"
    priority                   = 700
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "5432"
    destination_port_range     = "5432"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

# resource "azurerm_network_security_group" "bastion" {
#   name                = "bastion-sg"
#   location            = data.azurerm_resource_group.this.location
#   resource_group_name = data.azurerm_resource_group.this.name


#   security_rule {
#     name                       = "Allow_All"
#     priority                   = 1000
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "*"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

# }


resource "azurerm_network_interface_security_group_association" "db" {
  network_interface_id      = azurerm_network_interface.private.id
  network_security_group_id = azurerm_network_security_group.this.id
}


# resource "azurerm_subnet_network_security_group_association" "bastion" {
#   subnet_id                 = module.network.pub-subnets["${local.subnets.app}"]
#   network_security_group_id = azurerm_network_security_group.bastion.id
# }