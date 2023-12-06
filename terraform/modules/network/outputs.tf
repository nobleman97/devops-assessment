output "pub-subnets" {
  description = "Output used to pass subnet ids which was used to call machine module"
  value = { for sub in azurerm_subnet.public :
    sub.name => sub.id 
  }

}


output "priv-subnets" {
  description = "Output used to pass subnet ids which was used to call machine module"
  value = { for sub in azurerm_subnet.private :
    sub.name => sub.id
  }

}

output "sp-subnets" {
  description = "Subnet objects for the service plans"
  value = { for sub in azurerm_subnet.app_service:
    sub.name => sub.id
  }
}

