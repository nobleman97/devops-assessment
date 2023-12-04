
resource "azurerm_resource_group" "knixat-student-demo" {
  name     = "knixat-student-demo"
  location = "eastus2"

    tags = {

    "Environment" = "Demo",
    "owner"       = "Knixat",
    "Created_On"  = "16/10/2023" 
  }
}

resource "azurerm_service_plan" "knixat-demo" {
  name                = "knixat-demo"
  resource_group_name = data.azurerm_resource_group.david.name
  location            = "eastus2"
  os_type             = "Linux"
  sku_name            = "P0v3"
}

resource "azurerm_linux_web_app" "noble-webapp" {
  name                = "noble-webapp"
  resource_group_name = data.azurerm_resource_group.david.name
  location            = azurerm_service_plan.knixat-demo.location
  service_plan_id     = azurerm_service_plan.knixat-demo.id

  site_config {
    application_stack {
      docker_registry_url      = "https://index.docker.io"
      docker_image_name        = "4568910/2048-game:latest"
      docker_registry_username = "4568910"
      docker_registry_password = var.docker_registry_password

    }
  }

    logs {
      application_logs {
        file_system_level = "Verbose"
        # azure_blob_storage {
        #   level = "Verbose"
        #   sas_url = "https://knixatlogs.blob.core.windows.net/?sv=2022-11-02&ss=bf&srt=sco&sp=rwdlaciytfx&se=2023-12-02T19:27:36Z&st=2023-12-02T11:27:36Z&spr=https&sig=uhI01NGpSRrArwt87q01qzYMWBMEMZw31NyVDh%2Fj7K8%3D"
        #   retention_in_days = 30
        # }
      }

      detailed_error_messages = true
      
    }

}



