

variable "location" {
  type = string
  default = "eastus2"
}

variable "docker_registry_password" {
  sensitive = true
  type = string
  description = "Password to access your docker registry"
}

variable "connection_string" {
  sensitive = true
  type = string
  description = "connection string to allow app speak with server"
}

variable "vm-pub-key" {
  description = "Public key with which we can access our VMs"
  type = string
}