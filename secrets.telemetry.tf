#######################################################
# TELEMETRY
#######################################################

resource "databricks_secret_scope" "telemetry" {
  provider = databricks
  name     = "telemetry"
}

resource "databricks_secret_acl" "telemetry_unity" {
  principal  = "users"
  permission = "READ"
  scope      = databricks_secret_scope.telemetry.name
}

resource "databricks_secret" "telemetry_connection_string" {
  key          = "connection-string"
  string_value = var.telemetry_connection_string
  scope        = databricks_secret_scope.telemetry.name
}
