output "security_scope" {
  value       = databricks_secret_scope.security.name
  description = "Databricks security scope name."
}

output "databricks_group_analysts" {
  value       = databricks_group.analysts
  description = "Databricks Analysts group."
}

output "spn_id_value" {
  value       = data.azurerm_key_vault_secret.spn_id.value
  description = "SPN ID value"
}

output "spn_secret_key" {
  value       = databricks_secret.spn_secret.key
  description = "SPN Secret key."
}

output "analyst_group_name" {
  value = databricks_group.analysts.display_name
}

output "read_group_name" {
  value = databricks_group.readonly
}
