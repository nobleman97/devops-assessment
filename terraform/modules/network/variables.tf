

variable "vnets" {
  description = "A map of objects holding configuration details for vnets"
  type = map(object({
    name          = string
    location      = string
    address_space = list(string)
  }))
  default = {
    "eastus2" = {
      name          = "demo"
      location      = "eastus2"
      address_space = ["10.0.0.0/16"]
    }
  }
}

variable "pub-subnets" {
  description = "A map of objects holding configuration details for subnets"
  type = map(object({
    name             = string
    location         = string
    address_prefixes = list(string)
  }))
  default = {
    "subnet1_eastus2" = {
      name             = "subnet1_eastus2"
      location         = "eastus2"
      address_prefixes = ["10.0.1.0/24"]
    }
  }
}

variable "priv-subnets" {
  description = "A map of objects holding configuration details for subnets"
  type = map(object({
    name             = string
    location         = string
    address_prefixes = list(string)
  }))
  default = {
    "subnet2_eastus2" = {
      name             = "subnet2_eastus2"
      location         = "eastus2"
      address_prefixes = ["10.0.2.0/24"]
    }
  }
}

variable "service_plan-subs" {
  type = map(object({
    name = string
    location         = string
    address_prefixes = list(string)
  }))

  default = {
    "subnet3_eastus2" = {
      name = "subnet3_eastus2"
      location         = "eastus2"
      address_prefixes = [ "10.0.3.0/24" ]}
  }
}

