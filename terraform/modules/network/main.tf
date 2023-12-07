resource "azurerm_virtual_network" "this" {
  for_each = var.vnets

  name                = each.value.name
  address_space       = each.value.address_space
  location            = each.value.location
  resource_group_name = data.azurerm_resource_group.this.name
}


# resource "azurerm_subnet" "public" {
#   for_each = tomap(var.pub-subnets)

#   name                = each.value.name
#   resource_group_name = data.azurerm_resource_group.this.name

#   virtual_network_name = azurerm_virtual_network.this[each.value.location].name
#   address_prefixes     = each.value.address_prefixes
# }


resource "azurerm_subnet" "private" {
  for_each = tomap(var.priv-subnets)

  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.this.name

  virtual_network_name = azurerm_virtual_network.this[each.value.location].name
  address_prefixes     = each.value.address_prefixes

}

resource "azurerm_subnet" "app_service" {
  for_each = var.service_plan-subs

  name                = each.value.name
  resource_group_name = data.azurerm_resource_group.this.name

  virtual_network_name = azurerm_virtual_network.this[each.value.location].name
  address_prefixes     = each.value.address_prefixes

  delegation {
    name = "service-plan-delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

}



