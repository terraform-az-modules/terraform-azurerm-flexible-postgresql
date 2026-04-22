## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| active\_directory\_auth\_enabled | Whether Active Directory authentication is allowed to access the PostgreSQL Flexible Server | `bool` | `true` | no |
| admin\_objects\_ids | IDs of the objects that can do all operations on all keys, secrets and certificates. | `list(string)` | `[]` | no |
| admin\_password | The password associated with the admin\_username user | `string` | `null` | no |
| admin\_password\_length | Length of the randomly generated admin password, if not provided. | `number` | `16` | no |
| admin\_username | The administrator login name for the new SQL Server | `string` | `null` | no |
| auto\_grow\_enabled | Is the storage auto grow for PostgreSQL Flexible Server enabled? Defaults to false | `bool` | `false` | no |
| backup\_retention\_days | The backup retention days for the PostgreSQL Flexible Server. Possible values are between 1 and 35 days. Defaults to 30 | `number` | `30` | no |
| charset | Specifies the Charset for the PostgreSQL Database, which needs to be a valid PostgreSQL Charset. Changing this forces a new resource to be created. | `string` | `"utf8"` | no |
| cmk\_encryption\_enabled | Enable customer-managed key (CMK) encryption for the PostgreSQL Flexible Server. | `bool` | `true` | no |
| collation | Specifies the Collation for the PostgreSQL Database, which needs to be a valid PostgreSQL Collation. Changing this forces a new resource to be created. | `string` | `"en_US.utf8"` | no |
| create\_mode | The creation mode. Can be used to restore or replicate existing servers. Possible values are `Default`, `Replica`, `GeoRestore`, and `PointInTimeRestore`. Defaults to `Default` | `string` | `"Default"` | no |
| custom\_name | Override the default naming convention. | `string` | `null` | no |
| database\_names | List of the names of the PostgreSQL Databases, which needs to be a valid PostgreSQL identifier. Changing this forces a new resource to be created. | `list(string)` | `[]` | no |
| delegated\_subnet\_id | The resource ID of the subnet | `string` | `null` | no |
| deployment\_mode | Specifies how the infrastructure/resource is deployed | `string` | `"terraform"` | no |
| enable\_diagnostic | Flag to control creation of diagnostic settings. | `bool` | `true` | no |
| enable\_private\_endpoint | Manages a Private Endpoint to Azure database for PostgreSQL | `bool` | `false` | no |
| enabled | Set to false to prevent the module from creating any resources. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| eventhub\_authorization\_rule\_id | Eventhub authorization rule id to pass it to destination details of diagnosys setting of NSG. | `string` | `null` | no |
| eventhub\_name | Eventhub Name to pass it to destination details of diagnosys setting of NSG. | `string` | `null` | no |
| extra\_tags | Variable to pass extra tags. | `map(string)` | `null` | no |
| firewall\_rules | List of firewall rules to apply to the PostgreSQL Flexible Server.<br>Only used when public\_network\_access\_enabled = true.<br>For a single IP set start\_ip\_address and end\_ip\_address to the same value. | <pre>list(object({<br>    name             = string<br>    start_ip_address = string<br>    end_ip_address   = string<br>  }))</pre> | `[]` | no |
| generate\_random\_password | Set to true to auto-generate a random admin password when admin\_password is not provided.<br>Generated password is stored in Terraform state.<br>When false (default), admin\_password must be explicitly provided. | `bool` | `false` | no |
| geo\_backup\_key\_vault\_key\_id | Key-vault key id to encrypt the geo redundant backup | `string` | `null` | no |
| geo\_backup\_user\_assigned\_identity\_id | User assigned identity id to encrypt the geo redundant backup | `string` | `null` | no |
| geo\_redundant\_backup\_enabled | Should geo redundant backup enabled? Defaults to false. Changing this forces a new PostgreSQL Flexible Server to be created. | `bool` | `false` | no |
| high\_availability | Map of high availability configuration: https://docs.microsoft.com/en-us/azure/mysql/flexible-server/concepts-high-availability. `null` to disable high availability | <pre>object({<br>    mode                      = string<br>    standby_availability_zone = optional(number)<br>  })</pre> | `null` | no |
| key\_expiration\_date | The expiration date for the Key Vault key | `string` | `"2028-12-31T23:59:59Z"` | no |
| key\_permissions | List of key permissions for the Key Vault key. | `list(string)` | <pre>[<br>  "decrypt",<br>  "encrypt",<br>  "sign",<br>  "unwrapKey",<br>  "verify",<br>  "wrapKey"<br>]</pre> | no |
| key\_size | The size of the RSA key in bits. | `number` | `2048` | no |
| key\_type | The type of the key to create in Key Vault. | `string` | `"RSA"` | no |
| key\_vault\_id | Azure Key Vault ID for integration. | `string` | `null` | no |
| label\_order | Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] . | `list(any)` | `[]` | no |
| location | The Azure Region where the PostgreSQL Flexible Server should exist. Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | `""` | no |
| log\_analytics\_destination\_type | Possible values are AzureDiagnostics and Dedicated, default to AzureDiagnostics. When set to Dedicated, logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table. | `string` | `"AzureDiagnostics"` | no |
| log\_analytics\_workspace\_id | Log Analytics workspace id in which logs should be retained. | `string` | `null` | no |
| log\_category | Categories of logs to be recorded in diagnostic setting. Acceptable values are PostgreSQLFlexDatabaseXacts, PostgreSQLFlexQueryStoreRuntime, PostgreSQLFlexQueryStoreWaitStats ,PostgreSQLFlexSessions, PostgreSQLFlexTableStats, PostgreSQLLogs | `list(string)` | `[]` | no |
| log\_category\_group | Log category group for diagnostic settings. | `list(string)` | <pre>[<br>  "audit"<br>]</pre> | no |
| maintenance\_window\_day\_of\_week | The day of the week for the maintenance window, where the week starts on a Sunday, i.e. Sunday = 0, Monday = 1 | `number` | `2` | no |
| maintenance\_window\_enabled | Enable maintenance window configuration on the PostgreSQL Flexible Server. Defaults to false | `bool` | `false` | no |
| maintenance\_window\_start\_hour | The start hour for the maintenance window, in UTC | `number` | `6` | no |
| maintenance\_window\_start\_minute | The start minute for the maintenance window | `number` | `0` | no |
| managedby | ManagedBy, eg: `Terraform`, `Ansible`, `CloudFormation`. | `string` | `"Terraform"` | no |
| metric\_enabled | Whether metric diagnosis should be enabled in diagnostic settings for flexible PostgreSQL. | `bool` | `true` | no |
| min\_lower | Minimum number of lowercase letters in the generated password. | `number` | `2` | no |
| min\_numeric | Minimum number of numeric characters in the generated password. | `number` | `4` | no |
| min\_upper | Minimum number of uppercase letters in the generated password. | `number` | `4` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| password\_auth\_enabled | Whether password authentication is allowed to access the PostgreSQL Flexible Server | `bool` | `true` | no |
| point\_in\_time\_restore\_time\_in\_utc | The point in time to restore from creation\_source\_server\_id when create\_mode is PointInTimeRestore. Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | `null` | no |
| postgresql\_version | The version of the PostgreSQL Flexible Server to use. Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | `"16"` | no |
| principal\_name | The name of Azure Active Directory principal. | `string` | `null` | no |
| principal\_type | Set the principal type, defaults to ServicePrincipal. The type of Azure Active Directory principal. Possible values are Group, ServicePrincipal and User. Changing this forces a new resource to be created. | `string` | `"Group"` | no |
| private\_dns\_zone\_id | The ID of the Private DNS Zone to associate with the PostgreSQL Flexible Server Private Endpoint. | `string` | `null` | no |
| private\_endpoint\_location | The Location for the private Endpoint of PostgreSQL Flexible Server. | `string` | `null` | no |
| private\_endpoint\_subnet\_id | The subnet ID where the private endpoint will be deployed | `string` | `null` | no |
| public\_network\_access\_enabled | Defines whether public access is allowed. | `bool` | `false` | no |
| repository | Terraform current module repo | `string` | `""` | no |
| resource\_group\_name | A container that holds related resources for an Azure solution | `string` | `"pgsql-rg"` | no |
| resource\_position\_prefix | Controls placement of the resource type keyword (e.g., "vnet", "ddospp") in resource names.<br><br>- If true, the keyword is prepended: "vnet-core-dev".<br>- If false, the keyword is appended: "core-dev-vnet".<br><br>Maintains naming consistency based on organizational preferences. | `bool` | `true` | no |
| rotation\_policy\_config | Rotation policy configuration for Key Vault keys. | <pre>object({<br>    enabled              = bool<br>    time_before_expiry   = optional(string, "P30D")<br>    expire_after         = optional(string, "P90D")<br>    notify_before_expiry = optional(string, "P29D")<br>  })</pre> | <pre>{<br>  "enabled": false,<br>  "expire_after": "P90D",<br>  "notify_before_expiry": "P29D",<br>  "time_before_expiry": "P30D"<br>}</pre> | no |
| server\_configuration | Map of PostgreSQL Flexible Server configuration parameters to their values.<br>azure.extensions is managed automatically — use var.azure\_extensions and<br>var.enable\_pgvector instead of setting it manually here to avoid conflicts. | `map(string)` | <pre>{<br>  "pgaudit.log": "ALL"<br>}</pre> | no |
| sku\_name | The SKU Name for the PostgreSQL Flexible Server. | `string` | `"Standard_B1ms"` | no |
| source\_server\_id | The resource ID of the source PostgreSQL Flexible Server to be restored. Required when create\_mode is PointInTimeRestore, GeoRestore, and Replica. Changing this forces a new PostgreSQL Flexible Server to be created. | `string` | `null` | no |
| special | Whether to include special characters in the generated password. | `bool` | `false` | no |
| storage\_account\_id | Storage account id to pass it to destination details of diagnosys setting of NSG. | `string` | `null` | no |
| storage\_mb | The max storage allowed for the PostgreSQL Flexible Server. Possible values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, and 16777216. | `string` | `"32768"` | no |
| vnet\_int\_private\_dns\_zone\_id | The ID of the Private DNS Zone to associate with the PostgreSQL Flexible Server. | `string` | `null` | no |
| zone | Specifies the Availability Zone in which this PostgreSQL Flexible Server should be located. Possible values are 1, 2 and 3. | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| firewall\_rule\_ids | Map of firewall rule names to their resource IDs. |
| postgresql\_flexible\_server\_id | The ID of the PostgreSQL Flexible Server. |
| postgresql\_flexible\_server\_name | The FQDN of the PostgreSQL Flexible Server. |

