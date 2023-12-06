output "postgres-ip" {
  value = azurerm_network_interface.private.private_ip_address
}