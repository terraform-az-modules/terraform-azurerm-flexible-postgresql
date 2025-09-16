<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.116.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.43.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_flexible-postgresql"></a> [flexible-postgresql](#module\_flexible-postgresql) | ../.. | n/a |
| <a name="module_log-analytics"></a> [log-analytics](#module\_log-analytics) | terraform-az-modules/log-analytics/azure | 1.0.0 |
| <a name="module_private_dns"></a> [private\_dns](#module\_private\_dns) | terraform-az-modules/private-dns/azure | 1.0.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform-az-modules/resource-group/azure | 1.0.0 |
| <a name="module_subnet"></a> [subnet](#module\_subnet) | terraform-az-modules/subnet/azure | 1.0.0 |
| <a name="module_vault"></a> [vault](#module\_vault) | terraform-az-modules/key-vault/azure | 1.0.0 |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | terraform-az-modules/vnet/azure | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_client_config.current_client_config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_zone_id_keyvault"></a> [dns\_zone\_id\_keyvault](#output\_dns\_zone\_id\_keyvault) | The ID of dns zone. |
| <a name="output_dns_zone_name_keyvault"></a> [dns\_zone\_name\_keyvault](#output\_dns\_zone\_name\_keyvault) | The name of dns zone. |
| <a name="output_flexible-postgresql_server_id"></a> [flexible-postgresql\_server\_id](#output\_flexible-postgresql\_server\_id) | The ID of the MySQL Flexible Server. |
| <a name="output_flexible-postgresql_server_name"></a> [flexible-postgresql\_server\_name](#output\_flexible-postgresql\_server\_name) | The Name of the MySQL Flexible Server. |
<!-- END_TF_DOCS -->