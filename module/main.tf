module "module_rg" {
  source = "../rg"
  rg_map = var.module_rg
}

module "module_vnet" {
  depends_on = [module.module_rg]
  source     = "../vnet"
  vnet_map   = var.module_vnet
}

module "module_subnet" {
    depends_on = [ module.module_vnet ]
    source = "../subnet"
    subnet = var.module_rg
}

module "module_keyvault" {
    depends_on = [ module.module_rg ]
    source = "../key-vault"
    key_vault_map = var.module_rg
}

module "module_bastion" {
    depends_on = [ module.module_rg, module.module_vnet, module.module_subnet ]
    source = "../bastion"
    bastion_map = var.module_rg
}

# module "module_database" {
#     depends_on = [ module.module_rg ]
#     source = "../database"

# }