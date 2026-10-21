

resource "azurerm_linux_virtual_machine" "vms" {
  for_each                        = var.vms
  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = data.azurerm_key_vault_secret.username[each.key].value
  admin_password                  = data.azurerm_key_vault_secret.password[each.key].value
  disable_password_authentication = false
  network_interface_ids           = [data.azurerm_network_interface.nic_data[each.key].id]



  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
data "azurerm_network_interface" "nic_data" {
  for_each            = var.vms
  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name

}

data "azurerm_key_vault" "kv" {
  for_each            = var.vms
  name                = each.value.keyvault-name
  resource_group_name = each.value.key_rgname
}

#VM_username

data "azurerm_key_vault_secret" "username" {
  for_each     = var.vms
  name         = each.value.secret-name
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

# Password secret
data "azurerm_key_vault_secret" "password" {
  for_each     = var.vms
  name         = each.value.secret-password
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}
