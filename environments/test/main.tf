###
# environment composition
###

module "network_hub" {
  source               = "../../modules/azure/network_hub"
  environment          = var.environment
  region               = var.region
  address_space        = var.address_space
  address_prefixes     = var.address_prefixes
  address_prefix_vgw   = var.address_prefix_vgw
  subnet_name_prefixes = var.subnet_name_prefixes
  tags                 = var.tags
}

module "network_spoke" {
  source                                  = "../../modules/azure/network_spoke"
  environment                             = var.environment
  region                                  = var.region
  address_space                           = var.spoke_address_space
  address_prefixes                        = var.address_prefixes_spoke
  virtual_network_hub_resource_group_name = module.network_hub.virtual_network_resource_group_name
  virtual_network_hub_name                = module.network_hub.virtual_network_name
  virtual_network_hub_id                  = module.network_hub.virtual_network_id
  subnet_name_prefixes                    = var.spoke_subnet_name_prefixes
  tags                                    = var.tags
}

module "aks_agw_ingress" {
  source             = "../../modules/azure/aks_agw_ingress"
  environment        = var.environment
  region             = var.region
  client_secret      = var.client_secret
  subnet_id_agw      = module.network_spoke[0].subnet_id
  subnet_id_aks      = module.network_spoke[1].subnet_id
  dns_service_ip     = var.dns_service_ip
  docker_bridge_cidr = var.docker_bridge_cidr
  service_cidr       = var.service_cidr

  tags = var.tags
}