module "resource" {
  source = "../child_module/resource_group"
  rg_s   = var.rg_s
}

module "vnet" {
  depends_on = [module.resource]
  source     = "../child_module/virtual_network"
  vnet       = var.vnet

}

module "subnet" {
  depends_on = [module.vnet, module.resource]
  source     = "../child_module/subnet"
  subnet     = var.subnet

}
module "public_ip" {
  depends_on = [module.resource]
  source     = "../child_module/public_ip"
  public_ip  = var.public_ip

}

module "nsg" {
  depends_on = [module.resource]
  source     = "../child_module/NSG"
  nsg        = var.nsg

}

module "nics" {
  depends_on = [module.resource]
  source     = "../child_module/NIC"

  nics = var.nics
}

module "vms" {
  depends_on = [module.nics, module.resource]
  source     = "../child_module/virtual_machine"
  vms        = var.vms

}

module "bastion" {
  depends_on = [ module.resource,module.vnet,module.public_ip ]
  source = "../child_module/bastion"

  bastions = var.bastions
  
}