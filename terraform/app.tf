resource "azurerm_service_plan" "main" {
  name                = "assessment"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  os_type             = "Linux"
  sku_name            = "B2"

  depends_on = [ module.app-vm.vms ]
}

resource "azurerm_linux_web_app" "main" {
  name                = "visitors-app-cwee233"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    application_stack {
      docker_registry_url = "https://index.docker.io"
      docker_image_name = "4568910/devops-assessment:latest"
      docker_registry_password = var.docker_registry_password
      docker_registry_username = "4568910"
    }
  }

  app_settings = {
    "DATABASE_URL" = var.connection_string
  }

  virtual_network_subnet_id = module.network.sp-subnets["${local.subnets.sp-sub}"] 

  depends_on = [ azurerm_service_plan.main ]
}

# resource "azurerm_app_service_virtual_network_swift_connection" "vnet-integration" {
#   subnet_id = module.network.sp-subnets["${local.subnets.sp-sub}"] # local is in main.tf
#   app_service_id = azurerm_linux_web_app.main.id

# }