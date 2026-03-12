##----------------------------------------------------------------------------- 
## Locals
##-----------------------------------------------------------------------------
locals {
  name = var.custom_name != null ? var.custom_name : module.labels.id

  # Final list of extensions to allowlist. 'vector' is merged in automatically
  # when enable_pgvector = true; duplicates are removed and names uppercased
  # as Azure requires (e.g., "VECTOR,PG_TRGM").
  azure_extensions_list = distinct([
    for e in concat(
      [for x in var.azure_extensions : upper(x)],
      var.enable_pgvector ? ["VECTOR"] : []
    ) : e
  ])

}
