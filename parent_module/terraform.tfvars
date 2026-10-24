rg_s = {
  rg1 = {
    name     = "rg-24"
    location = "centralindia"

  }
}

vnet = {
  vnet1 = {
    name                = "vnet-24"
    location            = "centralindia"
    resource_group_name = "rg-24"
    address_space       = ["10.0.0.0/16"]
  }
}
subnet = {
  subnet1 = {
    name                 = "frontend_subnet"
    virtual_network_name = "vnet-24"
    resource_group_name  = "rg-24"
    address_prefixes     = ["10.0.1.0/24"]

  }
  subnet2 = {
    name                 = "AzureBastionSubnet"
    virtual_network_name = "vnet-24"
    resource_group_name  = "rg-24"
    address_prefixes     = ["10.0.2.0/24"]

  }
}
public_ip = {
  publicip1 = {
    name                = "publicip-24"
    resource_group_name = "rg-24"
    location            = "centralindia"
    allocation_method   = "Static"
  }
}


nsg = {
  nsg1 = {
    name                = "nsg-24"
    location            = "centralindia"
    resource_group_name = "rg-24"
  }
}
nics = {
  nic1 = {
    name                          = "nic-24"
    location                      = "centralindia"
    resource_group_name           = "rg-24"
    ipname                        = "ip-cnfig"
    private_ip_address_allocation = "Dynamic"
    subnet_name                   = "frontend_subnet"
    virtual_network_name          = "vnet-24"

  }
}

vms = {
  vm1 = {
    name                = "devopsadmin"
    resource_group_name = "rg-24"
    location            = "centralindia"
    size                = "Standard_D4_v5"
    nic_name            = "nic-24"
    keyvault-name       = "keyvault2310026"
    secret-name         = "vm-username"
    secret-password     = "vm-password"
  }
}

bastions = {
  bastion1 = {

    name                  = "azurebastion"
    location              = "centralindia"
    resource_group_name   = "rg-24"
    ip_configuration_name = "configuration"
    subnet                = "AzureBastionSubnet"
    virtual_network_name  = "vnet-24"
    public_ip             = "publicip-24"
  }
}
key_vault = {

  keyvault1 = {

    name                = "keyvault2310026"
    location            = "centralindia"
    resource_group_name = "rg-24"
    username            = "vm-username"
    password            = "vm-password"
  }
}

