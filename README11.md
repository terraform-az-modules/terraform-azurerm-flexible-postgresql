<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.116.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.116.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | terraform-az-modules/tags/azurerm | 1.0.2 |

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.postgresql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_postgresql_flexible_server.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_active_directory_administrator.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_active_directory_administrator) | resource |
| [azurerm_postgresql_flexible_server_configuration.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_database.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_postgresql_server_key.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server_key) | resource |
| [azurerm_private_endpoint.pep](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.identity_assigned](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.rbac_keyvault_crypto_officer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azuread_group.main](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_active_directory_auth_enabled"></a> [active\_directory\_auth\_enabled](#input\_active\_directory\_auth\_enabled) | Whether Active Directory authentication is allowed to access the PostgreSQL Flexible Server | `bool` | `true` | no |
| <a name="input_admin_objects_ids"></a> [admin\_objects\_ids](#input\_admin\_objects\_ids) | IDs of the objects that can do all operations on all keys, secrets and certificates. | `list(string)` | `[]` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The password associated with the admin\_username user | `string` | `null` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The administrator login name for the new SQL Server | `string` | `null` | no |
| <a name="input_auto_grow_enabled"></a> [auto\_grow\_enabled](#input\_auto\_grow\_enabled) | Is the storage auto grow for PostgreSQL Flexible Server enabled? Defaults to false | `bool` | `false` | no |
| <a name="input_backup_retention_days"></a> [backup\_retention\_days](#input\_backup\_retention\_days) | The backup retention days for the PostgreSQL Flexible Server. Possible values are between 1 and 35 days. Defaults to 7 | `number` | `30` | no |
| <a name="input_charset"></a> [charset](#input\_charset) | Specifies the Charset for the PostgreSQL Database, which needs to be a valid PostgreSQL Charset. Changing this forces a new resource to be created. | `string` | `"utf8"` | no |
| <a name="input_cmk_encryption_enabled"></a> [cmk\_encryption\_enabled](#input\_cmk\_encryption\_enabled) | Enable customer-managed key (CMK) encryption for the PostgreSQL Flexible Server. | `bool` | `false` | no |
| <a name="input_collation"></a> [collation](#input\_collation) | Specifies the Collation for the PostgreSQL Database, which needs to be a valid PostgreSQL Collation. Changing this forces a new resource to be created. | `string` | `"en_US.utf8"` | no |
| <a name="input_create_mode"></a> [create\_mode](#input\_create\_mode) | The creation mode. Can be used to restore or replicate existing servers. Possible values are `Default`, `Replica`, `GeoRestore`, and `PointInTimeRestore`. Defaults to `Default` | `string` | `"Default"` | no |
| <a name="input_custom_name"></a> [custom\_name](#input\_custom\_name) | Override the default naming convention. | `string` | `null` | no |
| <a name="input_database_names"></a> [database\_names](#input\_database\_names) | List of the names of the PostgreSQL Databases, which needs to be a valid PostgreSQL identifier. Changing this forces a new resource to be created. | `list(string)` | `[]` | no |
| <a name="input_delegated_subnet_id"></a> [delegated\_subnet\_id](#input\_delegated\_subnet\_id) | The resource ID of the subnet | `string` | `null` | no |
| <a name="input_deployment_mode"></a> [deployment\_mode](#input\_deployment\_mode) | Specifies how the infrastructure/resource is deployed | `string` | `"terraform"` | no |
| <a name="input_enable_diagnostic"></a> [enable\_diagnostic](#input\_enable\_diagnostic) | Flag to control creation of diagnostic settings. | `bool` | `true` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Manages a Private Endpoint to Azure database for PostgreSQL | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_eventhub_authorization_rule_id"></a> [eventhub\_authorization\_rule\_id](#input\_eventhub\_authorization\_rule\_id) | Eventhub authorization rule id to pass it to destination details of diagnosys setting of NSG. | `string` | `null` | no |
| <a name="input_eventhub_name"></a> [eventhub\_name](#input\_eventhub\_name) | Eventhub Name to pass it to destination details of diagnosys setting of NSG. | `string` | `null` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Variable to pass extra tags. | `map(string)` | `null` | no |
| <a name="input_geo_backup_key_vault_key_id"></a> [geo\_backup\_key\_vault\_key\_id](#input\_geo\_backup\_key\_vault\_key\_id) | Key-vault key id to encrypt the geo redundant backup | `string` | `null` | no |
| <a name="input_geo_backup_user_assigned_identity_id"></a> [geo\_backup\_user\_assigned\_identity\_id](#input\_geo\_backup\_user\_assigned\_identity\_id) | User assigned identity id to encrypt the geo redundant backup | `string` | `null` | no |
| <a name="input_geo_redundant_backup_enabled"></a> [geo\_redundant\_backup\_enabled](#input\_geo\_redundant\_backup\_enabled) | Should geo redundant backup enabled? Defaults to false. Changing this forces a new PostgreSQL Flexible Server to be created. | `bool` | `false` | no |
| <a name="input_high_availability"></a> [high\_availability](#input\_high\_availability) | Map of high availability configuration: https://docs.microsoft.com/en-us/azure/mysql/flexible-server/concepts-high-availability. `null` to disable high availability | <pre>object({<br>    mode                      = string<br>    standby_availability_zone = optional(number)<br>  })</pre> | <pre>{<br>  "mode": "SameZone",<br>  "standby_availability_zone": 1<br>}</pre> | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | Specifies the URL to a Key Vault Key (either from a Key Vault Key, or the Key URL for the Key Vault Secret | `string` | `""` | no |
| <a name="input_key_vault_key_id"></a> [key\_vault\_key\_id](#input\_key\_vault\_key\_id) | The URL to a Key Vault Key | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] . | `list(any)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the PostgreSQL Flexible Server should exist. Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | `""` | no |
| <a name="input_log_analytics_destination_type"></a> [log\_analytics\_destination\_type](#input\_log\_analytics\_destination\_type) | Possible values are AzureDiagnostics and Dedicated, default to AzureDiagnostics. When set to Dedicated, logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table. | `string` | `"AzureDiagnostics"` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | Log Analytics workspace id in which logs should be retained. | `string` | `null` | no |
| <a name="input_log_category"></a> [log\_category](#input\_log\_category) | Categories of logs to be recorded in diagnostic setting. Acceptable values are PostgreSQLFlexDatabaseXacts, PostgreSQLFlexQueryStoreRuntime, PostgreSQLFlexQueryStoreWaitStats ,PostgreSQLFlexSessions, PostgreSQLFlexTableStats, PostgreSQLLogs | `list(string)` | `[]` | no |
| <a name="input_log_category_group"></a> [log\_category\_group](#input\_log\_category\_group) | Log category group for diagnostic settings. | `list(string)` | <pre>[<br>  "audit"<br>]</pre> | no |
| <a name="input_maintenance_window_day_of_week"></a> [maintenance\_window\_day\_of\_week](#input\_maintenance\_window\_day\_of\_week) | The day of the week for the maintenance window, where the week starts on a Sunday, i.e. Sunday = 0, Monday = 1 | `number` | `2` | no |
| <a name="input_maintenance_window_enabled"></a> [maintenance\_window\_enabled](#input\_maintenance\_window\_enabled) | Enable maintenance window configuration on the PostgreSQL Flexible Server. Defaults to false | `bool` | `false` | no |
| <a name="input_maintenance_window_start_hour"></a> [maintenance\_window\_start\_hour](#input\_maintenance\_window\_start\_hour) | The start hour for the maintenance window, in UTC | `number` | `6` | no |
| <a name="input_maintenance_window_start_minute"></a> [maintenance\_window\_start\_minute](#input\_maintenance\_window\_start\_minute) | The start minute for the maintenance window | `number` | `0` | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | ManagedBy, eg: `Terraform`, `Ansible`, `CloudFormation`. | `string` | `"Terraform"` | no |
| <a name="input_metric_enabled"></a> [metric\_enabled](#input\_metric\_enabled) | Whether metric diagnonsis should be enable in diagnostic settings for flexible Mysql. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_password_auth_enabled"></a> [password\_auth\_enabled](#input\_password\_auth\_enabled) | Whether password authentication is allowed to access the PostgreSQL Flexible Server | `bool` | `true` | no |
| <a name="input_point_in_time_restore_time_in_utc"></a> [point\_in\_time\_restore\_time\_in\_utc](#input\_point\_in\_time\_restore\_time\_in\_utc) | The point in time to restore from creation\_source\_server\_id when create\_mode is PointInTimeRestore. Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | `null` | no |
| <a name="input_postgresql_version"></a> [postgresql\_version](#input\_postgresql\_version) | The version of the PostgreSQL Flexible Server to use. Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | `"16"` | no |
| <a name="input_principal_name"></a> [principal\_name](#input\_principal\_name) | The name of Azure Active Directory principal. | `string` | `null` | no |
| <a name="input_principal_type"></a> [principal\_type](#input\_principal\_type) | Set the principal type, defaults to ServicePrincipal. The type of Azure Active Directory principal. Possible values are Group, ServicePrincipal and User. Changing this forces a new resource to be created. | `string` | `"Group"` | no |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | The subnet ID where the private endpoint will be deployed | `string` | `null` | no |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | The subnet ID where the private endpoint will be deployed | `string` | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Defines whether public access is allowed. | `bool` | `false` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Terraform current module repo | `string` | `""` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | A container that holds related resources for an Azure solution | `string` | `"pgsql-rg"` | no |
| <a name="input_resource_position_prefix"></a> [resource\_position\_prefix](#input\_resource\_position\_prefix) | Controls placement of the resource type keyword (e.g., "vnet", "ddospp") in resource names.<br><br>- If true, the keyword is prepended: "vnet-core-dev".<br>- If false, the keyword is appended: "core-dev-vnet".<br><br>Maintains naming consistency based on organizational preferences. | `bool` | `true` | no |
| <a name="input_server_configuration_name"></a> [server\_configuration\_name](#input\_server\_configuration\_name) | Specifies the name of the PostgreSQL Flexible Server Configuration, which needs to be a valid PostgreSQL configuration name. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  "azure.extensions",<br>  "pgaudit.log"<br>]</pre> | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU Name for the PostgreSQL Flexible Server. | `string` | `"GP_Standard_D8ds_v4"` | no |
| <a name="input_source_server_id"></a> [source\_server\_id](#input\_source\_server\_id) | The resource ID of the source PostgreSQL Flexible Server to be restored. Required when create\_mode is PointInTimeRestore, GeoRestore, and Replica. Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | `null` | no |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | Storage account id to pass it to destination details of diagnosys setting of NSG. | `string` | `null` | no |
| <a name="input_storage_mb"></a> [storage\_mb](#input\_storage\_mb) | The max storage allowed for the PostgreSQL Flexible Server. Possible values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, and 16777216. | `string` | `"32768"` | no |
| <a name="input_values"></a> [values](#input\_values) | Specifies the value of the PostgreSQL Flexible Server Configuration. See the PostgreSQL documentation for valid values. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  "CUBE,CITEXT,BTREE_GIST,PGAUDIT",<br>  "ALL"<br>]</pre> | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Specifies the Availability Zone in which this PostgreSQL Flexible Server should be located. Possible values are 1, 2 and 3. | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_postgresql_flexible_server_id"></a> [postgresql\_flexible\_server\_id](#output\_postgresql\_flexible\_server\_id) | The ID of the PostgreSQL Flexible Server. |
| <a name="output_postgresql_flexible_server_name"></a> [postgresql\_flexible\_server\_name](#output\_postgresql\_flexible\_server\_name) | The FQDN of the PostgreSQL Flexible Server. |
<!-- END_TF_DOCS -->