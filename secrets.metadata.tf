################################################
# METADATA
################################################

# Contains information about the project and its execution context.
resource "databricks_secret_scope" "metadata" {
  name = "metadata"
}

resource "databricks_secret_acl" "metadata_unity" {
  principal  = "users"
  permission = "READ"
  scope      = databricks_secret_scope.metadata.name
}

# Databricks secret register

# The execution environment.
resource "databricks_secret" "environment" {
  key          = "ENVIRONMENT"
  string_value = upper(var.environment)
  scope        = databricks_secret_scope.metadata.name
}

# The project trigram.
resource "databricks_secret" "trigram" {
  key          = "TRIGRAM"
  string_value = upper(var.trigram)
  scope        = databricks_secret_scope.metadata.name
}
