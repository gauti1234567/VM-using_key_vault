resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastions
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = each.value.ip_configuration_name
    subnet_id      =   data.azurerm_subnet.data_subnet[each.key].id
    public_ip_address_id = data.azurerm_public_ip.data_public_ip[each.key].id
  }
}

data "azurerm_subnet" "data_subnet" {
  for_each = var.bastions
  name                 = each.value.subnet
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "data_public_ip" {
  for_each = var.bastions
  name                 = each.value.public_ip
  resource_group_name  = each.value.resource_group_name
}
