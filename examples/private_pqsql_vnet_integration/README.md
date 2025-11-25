<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.116.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.52.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_flexible-postgresql"></a> [flexible-postgresql](#module\_flexible-postgresql) | ../.. | n/a |
| <a name="module_log-analytics"></a> [log-analytics](#module\_log-analytics) | terraform-az-modules/log-analytics/azurerm | 1.0.2 |
| <a name="module_private_dns"></a> [private\_dns](#module\_private\_dns) | terraform-az-modules/private-dns/azurerm | 1.0.2 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform-az-modules/resource-group/azurerm | 1.0.3 |
| <a name="module_subnet"></a> [subnet](#module\_subnet) | terraform-az-modules/subnet/azurerm | 1.0.1 |
| <a name="module_vault"></a> [vault](#module\_vault) | terraform-az-modules/key-vault/azurerm | 1.0.1 |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | terraform-az-modules/vnet/azurerm | 1.0.3 |

## Resources

| Name | Type |
|------|------|
| [azurerm_client_config.current_client_config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_flexible-postgresql_server_id"></a> [flexible-postgresql\_server\_id](#output\_flexible-postgresql\_server\_id) | The ID of the PostgreSQL Flexible Server. |
| <a name="output_flexible-postgresql_server_name"></a> [flexible-postgresql\_server\_name](#output\_flexible-postgresql\_server\_name) | The Name of the PostgreSQL Flexible Server. |
<!-- END_TF_DOCS -->