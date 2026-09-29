
locals {
  production = var.environment == "PRD" || var.environment == "PRE"

  # tflint-ignore: terraform_unused_declarations
  users_group_name = "GRP_AZURE_DATA_${upper(var.data_scope)}_${local.production ? "PRD" : "NPD"}_USERS"
  # tflint-ignore: terraform_unused_declarations
  read_group_name = "GRP_AZURE_DATA_${upper(var.data_scope)}_${local.production ? "PRD" : "NPD"}_READERS"
}
