resource "azurerm_resource_group" "rg_s" {
  for_each = var.rg_s
  name     = each.value.name
  location = each.value.location
}
