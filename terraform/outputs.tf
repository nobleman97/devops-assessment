output "postgres-ip" {
  value = azurerm_network_interface.postgres.private_ip_address
}

# output "public_ip_address" {
#   value = azurerm_network_interface.postgres.ip_configuration[1].public_ip_address
# }
