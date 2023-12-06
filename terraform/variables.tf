

variable "location" {
  type = string
  default = "eastus2"
}

variable "docker_registry_password" {
  type = string
  description = "Password to access your docker registry"
}