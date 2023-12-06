variable "vm_map" {
  description = "This variable allow you to specify details for virtual machine you intend to provision"
  type = map(object({
    name           = string
    location       = string
    size           = string
    admin_username = string
    nic = list(string)
    admin_ssh_key = object({
      username   = string
      public_key = string
    })
  }))

  default = {
    "pub1" = {
      name           = "web"
      location       = "eastus2"
      size           = "Standard_B1s"
      admin_username = "saitama"
      nic = [ ]
      admin_ssh_key = {
        username   = "saitama"
        public_key = "~/.ssh/assessment.pub"
      }
    }
    # "priv1" = {
    #   name           = "mysql"
    #   location       = "eastus2"
    #   size           = "Standard_B1s"
    #   admin_username = "saitama"
    #   admin_ssh_key = {
    #     username   = "saitama"
    #     public_key = "~/.ssh/assessment.pub"
    #   }
    # }
  }
}

# variable "nic" {
#   type = list(string)
# }