output "pre_prod_vnet_spoke_name" {
  value       = module.pre-prod-network-spoke.vnet_spoke_name
  description = "Generated name of the Virtual Network"
}

output "pre_prod_vnet_spoke_rg" {
  value       = module.pre-prod-network-spoke.vnet_spoke_rg
  description = "Generated name of the Virtual Network resource group"
}

