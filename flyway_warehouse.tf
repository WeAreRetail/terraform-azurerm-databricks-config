resource "databricks_sql_endpoint" "flyway_sql_warehouse" {
  for_each = var.enable_flyway_warehouse ? {
    "enabled" = true
  } : {}

  name                      = "deployment-serverless-small"
  cluster_size              = "2X-Small"
  min_num_clusters          = 1
  max_num_clusters          = 1
  auto_stop_mins            = 15
  spot_instance_policy      = "COST_OPTIMIZED" # This is the default value
  enable_photon             = true             # This is the default value
  enable_serverless_compute = true
  warehouse_type            = "PRO" # This is the default value for serverless compute
  no_wait                   = true  # No need to wait for the resource to be started

  channel {
    name = "CHANNEL_NAME_CURRENT" # This is the default value
  }


  tags {
    custom_tags {
      key   = "BUDGET"
      value = "FLYWAY"
    }
  }
}
