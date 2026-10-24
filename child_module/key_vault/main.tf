variable "key_vault" {}
variable "vm-username" {}
variable "vm-password" {}


resource "azurerm_key_vault" "key_vault" {
  for_each                    = var.key_vault
  name                        = each.value.name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  rbac_authorization_enabled  = false
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
  
  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Purge"
  ]
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_secret" "username" {
  for_each     = var.key_vault
  name         = each.value.username
  value        = var.vm-username
  key_vault_id = azurerm_key_vault.key_vault[each.key].id
}

resource "azurerm_key_vault_secret" "password" {
  for_each     = var.key_vault
  name         = each.value.password
  value        = var.vm-password
  key_vault_id = azurerm_key_vault.key_vault[each.key].id
}

