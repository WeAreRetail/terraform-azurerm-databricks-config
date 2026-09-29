# Unity standardized groups

data "azuread_group" "app_unity" {
  display_name     = "GRP_UNI_AZURE_${upper(var.trigram)}_${upper(var.environment)}_APPLICATIONS"
  security_enabled = true
}

data "azuread_group" "delivery_unity" {
  display_name     = "GRP_UNI_AZURE_${upper(var.trigram)}_${upper(var.environment)}_DELIVERY"
  security_enabled = true
}

data "azuread_service_principals" "admin_unity" {
  object_ids     = toset(concat(data.azuread_group.app_unity.members, data.azuread_group.delivery_unity.members))
  ignore_missing = true
}

locals {
  app_admin_map = { for k, v in data.azuread_service_principals.admin_unity.service_principals : v.client_id => v.display_name }
}

resource "databricks_service_principal" "admins" {
  for_each = local.app_admin_map

  application_id = each.key
  display_name   = each.value
  force          = true
}

data "databricks_group" "admins" {
  display_name = "admins"
}

data "databricks_group" "users" {
  display_name = local.users_group_name
}

resource "databricks_group_member" "app-are-admin" {
  for_each = {
    for k, r in databricks_service_principal.admins : k => r
  }

  group_id  = data.databricks_group.admins.id
  member_id = each.value.id
}
