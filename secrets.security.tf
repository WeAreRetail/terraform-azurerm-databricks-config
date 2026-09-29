################################################
# SECURITY
################################################

resource "databricks_secret_scope" "security" {
  name = "security"
}

resource "databricks_secret_acl" "security_unity" {
  principal  = "users"
  permission = "READ"
  scope      = databricks_secret_scope.security.name
}

# Databricks secret register

resource "databricks_secret" "tenant_id" {
  key          = "tenant-id"
  string_value = var.tenant_id
  scope        = databricks_secret_scope.security.name
}

resource "databricks_secret" "client_id" {
  key          = "client-id"
  string_value = length(local.databricks_identities) > 0 ? one(local.databricks_identities) : "no_dbmanagedidentity"
  scope        = databricks_secret_scope.security.name
}
