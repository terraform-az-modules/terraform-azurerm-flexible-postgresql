##----------------------------------------------------------------------------- 
## Locals
##-----------------------------------------------------------------------------
locals {
  name = var.custom_name != null ? var.custom_name : module.labels.id
}

# locals {
#   resource_group_name = var.resource_group_name
#   location            = var.location
# }

