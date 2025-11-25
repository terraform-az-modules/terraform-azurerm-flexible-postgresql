##-----------------------------------------------------------------------------
## Naming convention
##-----------------------------------------------------------------------------
variable "custom_name" {
  type        = string
  default     = null
  description = "Override the default naming convention."
}

variable "resource_position_prefix" {
  type        = bool
  default     = true
  description = <<EOT
Controls placement of the resource type keyword (e.g., "vnet", "ddospp") in resource names.

- If true, the keyword is prepended: "vnet-core-dev".
- If false, the keyword is appended: "core-dev-vnet".

Maintains naming consistency based on organizational preferences.
EOT
}

#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "repository" {
  type        = string
  default     = ""
  description = "Terraform current module repo"
}

variable "label_order" {
  type        = list(any)
  default     = []
  description = "Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] ."
}

variable "managedby" {
  type        = string
  default     = "Terraform"
  description = "ManagedBy, eg: `Terraform`, `Ansible`, `CloudFormation`."
}

variable "deployment_mode" {
  type        = string
  default     = "terraform"
  description = "Specifies how the infrastructure/resource is deployed"
}

variable "extra_tags" {
  type        = map(string)
  default     = null
  description = "Variable to pass extra tags."
}

variable "resource_group_name" {
  type        = string
  default     = "pgsql-rg"
  description = "A container that holds related resources for an Azure solution"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

variable "enable_private_endpoint" {
  type        = bool
  default     = false
  description = "Manages a Private Endpoint to Azure database for PostgreSQL"

}

###########azurerm_postgresql_flexible_server######

variable "admin_username" {
  type        = string
  default     = null
  description = "The administrator login name for the new SQL Server"
}

variable "admin_password" {
  type        = string
  default     = null
  description = "The password associated with the admin_username user"
}

variable "admin_password_length" {
  type        = number
  default     = 16
  description = "Length of the randomly generated admin password, if not provided."
}

variable "backup_retention_days" {
  type        = number
  default     = 30
  description = "The backup retention days for the PostgreSQL Flexible Server. Possible values are between 1 and 35 days. Defaults to 30"
}

variable "delegated_subnet_id" {
  type        = string
  default     = null
  description = "The resource ID of the subnet"
}

variable "sku_name" {
  type        = string
  default     = "Standard_B1ms"
  description = " The SKU Name for the PostgreSQL Flexible Server."
}

variable "create_mode" {
  type        = string
  default     = "Default"
  description = "The creation mode. Can be used to restore or replicate existing servers. Possible values are `Default`, `Replica`, `GeoRestore`, and `PointInTimeRestore`. Defaults to `Default`"
}

variable "geo_redundant_backup_enabled" {
  type        = bool
  default     = false
  description = "Should geo redundant backup enabled? Defaults to false. Changing this forces a new PostgreSQL Flexible Server to be created."
}

variable "postgresql_version" {
  type        = string
  default     = "16"
  description = "The version of the PostgreSQL Flexible Server to use. Changing this forces a new PostgreSQL Flexible Server to be created."
}

variable "zone" {
  type        = number
  default     = 1
  description = "Specifies the Availability Zone in which this PostgreSQL Flexible Server should be located. Possible values are 1, 2 and 3."
}

variable "point_in_time_restore_time_in_utc" {
  type        = string
  default     = null
  description = " The point in time to restore from creation_source_server_id when create_mode is PointInTimeRestore. Changing this forces a new PostgreSQL Flexible Server to be created."
}

variable "maintenance_window_day_of_week" {
  type        = number
  default     = 2
  description = "The day of the week for the maintenance window, where the week starts on a Sunday, i.e. Sunday = 0, Monday = 1"
}

variable "maintenance_window_start_hour" {
  type        = number
  default     = 6
  description = "The start hour for the maintenance window, in UTC"
}

variable "maintenance_window_start_minute" {
  type        = number
  default     = 0
  description = "The start minute for the maintenance window"
}

variable "source_server_id" {
  type        = string
  default     = null
  description = "The resource ID of the source PostgreSQL Flexible Server to be restored. Required when create_mode is PointInTimeRestore, GeoRestore, and Replica. Changing this forces a new PostgreSQL Flexible Server to be created."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Defines whether public access is allowed."
}

variable "location" {
  type        = string
  default     = ""
  description = "The Azure Region where the PostgreSQL Flexible Server should exist. Changing this forces a new PostgreSQL Flexible Server to be created."
}

variable "server_configuration_name" {
  type = list(string)
  default = [
    "azure.extensions",
    "pgaudit.log",
  ]
  description = "Specifies the name of the PostgreSQL Flexible Server Configuration, which needs to be a valid PostgreSQL configuration name. Changing this forces a new resource to be created."
}

variable "values" {
  type = list(string)
  default = [
    "CUBE,CITEXT,BTREE_GIST,PGAUDIT",
    "ALL",
  ]
  description = "Specifies the value of the PostgreSQL Flexible Server Configuration. See the PostgreSQL documentation for valid values. Changing this forces a new resource to be created."
}

variable "storage_mb" {
  type        = string
  default     = "32768"
  description = "The max storage allowed for the PostgreSQL Flexible Server. Possible values are 32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, and 16777216."
}

variable "auto_grow_enabled" {
  type        = bool
  default     = false
  description = "Is the storage auto grow for PostgreSQL Flexible Server enabled? Defaults to false"
}

variable "charset" {
  type        = string
  default     = "utf8"
  description = "Specifies the Charset for the PostgreSQL Database, which needs to be a valid PostgreSQL Charset. Changing this forces a new resource to be created."
}

variable "collation" {
  type        = string
  default     = "en_US.utf8"
  description = "Specifies the Collation for the PostgreSQL Database, which needs to be a valid PostgreSQL Collation. Changing this forces a new resource to be created."
}

variable "high_availability" {
  description = "Map of high availability configuration: https://docs.microsoft.com/en-us/azure/mysql/flexible-server/concepts-high-availability. `null` to disable high availability"
  type = object({
    mode                      = string
    standby_availability_zone = optional(number)
  })
  default = null
}

variable "enable_diagnostic" {
  type        = bool
  default     = true
  description = "Flag to control creation of diagnostic settings."
}


variable "log_analytics_workspace_id" {
  type        = string
  default     = null
  description = "Log Analytics workspace id in which logs should be retained."
}

variable "metric_enabled" {
  type        = bool
  default     = true
  description = "Whether metric diagnosis should be enabled in diagnostic settings for flexible PostgreSQL."
}

variable "log_category" {
  type        = list(string)
  default     = []
  description = "Categories of logs to be recorded in diagnostic setting. Acceptable values are PostgreSQLFlexDatabaseXacts, PostgreSQLFlexQueryStoreRuntime, PostgreSQLFlexQueryStoreWaitStats ,PostgreSQLFlexSessions, PostgreSQLFlexTableStats, PostgreSQLLogs "
}

variable "log_category_group" {
  type        = list(string)
  default     = ["audit"]
  description = " Log category group for diagnostic settings."
}

variable "log_analytics_destination_type" {
  type        = string
  default     = "AzureDiagnostics"
  description = "Possible values are AzureDiagnostics and Dedicated, default to AzureDiagnostics. When set to Dedicated, logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table."
}

variable "storage_account_id" {
  type        = string
  default     = null
  description = "Storage account id to pass it to destination details of diagnosys setting of NSG."
}

variable "eventhub_name" {
  type        = string
  default     = null
  description = "Eventhub Name to pass it to destination details of diagnosys setting of NSG."
}

variable "eventhub_authorization_rule_id" {
  type        = string
  default     = null
  description = "Eventhub authorization rule id to pass it to destination details of diagnosys setting of NSG."
}

variable "active_directory_auth_enabled" {
  type        = bool
  default     = true
  description = "Whether Active Directory authentication is allowed to access the PostgreSQL Flexible Server"
}

variable "password_auth_enabled" {
  type        = bool
  default     = true
  description = "Whether password authentication is allowed to access the PostgreSQL Flexible Server"
}
variable "principal_type" {
  type        = string
  default     = "Group"
  description = "Set the principal type, defaults to ServicePrincipal. The type of Azure Active Directory principal. Possible values are Group, ServicePrincipal and User. Changing this forces a new resource to be created."
}

variable "principal_name" {
  type        = string
  default     = null
  description = "The name of Azure Active Directory principal."
}

variable "maintenance_window_enabled" {
  type        = bool
  default     = false
  description = "Enable maintenance window configuration on the PostgreSQL Flexible Server. Defaults to false"
}

variable "database_names" {
  type        = list(string)
  default     = []
  description = "List of the names of the PostgreSQL Databases, which needs to be a valid PostgreSQL identifier. Changing this forces a new resource to be created."

}

variable "cmk_encryption_enabled" {
  type        = bool
  default     = true
  description = "Enable customer-managed key (CMK) encryption for the PostgreSQL Flexible Server."
}

variable "admin_objects_ids" {
  type        = list(string)
  default     = []
  description = "IDs of the objects that can do all operations on all keys, secrets and certificates."
}

variable "private_endpoint_subnet_id" {
  type        = string
  default     = null
  description = "The subnet ID where the private endpoint will be deployed"
}

variable "private_dns_zone_id" {
  type        = string
  default     = null
  description = "The ID of the Private DNS Zone to associate with the PostgreSQL Flexible Server."
}

variable "private_dns_id" {
  type        = string
  default     = null
  description = "Private DNS zone id to be passed when we don't use private endpoint"
}

variable "geo_backup_key_vault_key_id" {
  type        = string
  default     = null
  description = "Key-vault key id to encrypt the geo redundant backup"
}

variable "geo_backup_user_assigned_identity_id" {
  type        = string
  default     = null
  description = "User assigned identity id to encrypt the geo redundant backup"
}

##-----------------------------------------------------------------------------
## Key Vault
##-----------------------------------------------------------------------------
variable "key_vault_id" {
  type        = string
  default     = null
  description = "Azure Key Vault ID for integration."
}

variable "rotation_policy_config" {
  type = object({
    enabled              = bool
    time_before_expiry   = optional(string, "P30D")
    expire_after         = optional(string, "P90D")
    notify_before_expiry = optional(string, "P29D")
  })
  default = {
    enabled              = false
    time_before_expiry   = "P30D"
    expire_after         = "P90D"
    notify_before_expiry = "P29D"
  }
  description = "Rotation policy configuration for Key Vault keys."
}

variable "key_permissions" {
  type        = list(string)
  default     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  description = "List of key permissions for the Key Vault key."
}

variable "key_expiration_date" {
  description = "The expiration date for the Key Vault key"
  type        = string
  default     = "2028-12-31T23:59:59Z" # ISO 8601 format
}

variable "key_type" {
  description = "The type of the key to create in Key Vault."
  type        = string
  default     = "RSA"
}

variable "key_size" {
  description = "The size of the RSA key in bits."
  type        = number
  default     = 2048
}