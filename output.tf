output "users_group_id" {
  description = "The Databricks group ID for the workspace users group."
  value       = data.databricks_group.users.id
}

output "job_policy_id" {
  description = "The current job cluster policy ID."
  value       = databricks_cluster_policy.job_current.id
}

output "notebook_policy_id" {
  description = "The current notebook cluster policy ID."
  value       = databricks_cluster_policy.notebook_current.id
}


output "flyway_sql_warehouse_jdbc_url" {
  description = "The JDBC URL for the Flyway SQL warehouse."
  value       = var.enable_flyway_warehouse ? databricks_sql_endpoint.flyway_sql_warehouse["enabled"].jdbc_url : null
}

output "flyway_sql_warehouse_odbc_params" {
  description = "The ODBC connection parameters for the Flyway SQL warehouse."
  value       = var.enable_flyway_warehouse ? databricks_sql_endpoint.flyway_sql_warehouse["enabled"].odbc_params : null
}
