data "databricks_sql_warehouses" "serverless_starter" {
  warehouse_name_contains = "Serverless Starter Warehouse"
}

resource "databricks_permissions" "serverless_starter" {
  for_each = toset(data.databricks_sql_warehouses.serverless_starter.ids)

  sql_endpoint_id = each.value

  access_control {
    group_name       = "users"
    permission_level = "CAN_VIEW"
  }
}
