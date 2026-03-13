##----------------------------------------------------------------------------- 
## Locals
##-----------------------------------------------------------------------------
locals {
  name = var.custom_name != null ? var.custom_name : module.labels.id

  # Extensions list — VECTOR auto-appended when enable_pgvector = true
  azure_extensions_list = distinct([
    for e in concat(
      [for x in var.azure_extensions : upper(x)],
      var.enable_pgvector ? ["VECTOR"] : []
    ) : e
  ])

  # Merges user-provided server_configuration map with auto-computed
  # azure.extensions value. If user accidentally puts azure.extensions
  # in server_configuration, the auto-computed value wins (overrides it).
  final_server_configuration = merge(
    var.server_configuration,
    length(local.azure_extensions_list) > 0 ? {
      "azure.extensions" = join(",", local.azure_extensions_list)
    } : {}
  )
}
