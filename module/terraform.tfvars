module_rg = {
  vm1 = {
    resource_group_name           = "sunil-baba-rg"
    location                      = "eastus2"
    subnet_name01                 = "frontend-subnet"
    address_prefixes              = ["10.0.1.0/24"]
    keyvault_name                 = "tiwarisecrets008"
    name_ip                       = "public-ip1"
    name_VM                       = "frontend-vm"
    vm_size                       = "Standard_F2"
    name_disk                     = "dardey-disco"
    caching                       = "ReadWrite"
    create_option                 = "FromImage"
    managed_disk_type             = "Standard_LRS"
    computer_name                 = "hostname1"
    private_ip_address_allocation = "Dynamic"
    bastion_name                  = "AzureBastionSubnet"
    bastion_address_prefixes      = ["10.0.4.0/27"]
    ip_name                       = "mypip1"
    allocation_method             = "Static"
    sku                           = "Standard"
    vnet_name                     = "sunil_vnet"
    stg_name                      = "stg01"
  }

  vm2 = {
    resource_group_name           = "sunil-baba-rg"
    location                      = "eastus2"
    subnet_name                   = "backend-subnet"
    address_prefixes              = ["10.0.2.0/24"]
    keyvault_name                 = "tiwarisecrets008"
    name_ip                       = "public-ip2"
    name_VM                       = "backend-vm"
    vm_size                       = "Standard_F2"
    name_disk                     = "dardey2-disco"
    caching                       = "ReadWrite"
    create_option                 = "FromImage"
    managed_disk_type             = "Standard_LRS"
    computer_name                 = "hostname1"
    private_ip_address_allocation = "Dynamic"
    bastion_name                  = "AzureBastionSubnet"
    bastion_address_prefixes      = ["10.0.5.0/27"]
    ip_name                       = "mypip2"
    allocation_method             = "Static"
    sku                           = "Standard"
    vnet_name                     = "sunil_vnet"
    stg_name                      = "stg01"
  }

}

module_vnet = {
  vnet01 = {
    vnet_name     = "sunil_vnet"
    vnet_location = "eastus2"
    rg_name       = "sunil-baba-rg"
    address_space = ["10.0.0.0/16"]
  }
}
