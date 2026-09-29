resource "databricks_cluster_policy" "notebook_17" {
  count      = contains(var.supported_databricks_major_versions, "17") ? 1 : 0
  name       = "aware-notebook-17"
  definition = jsonencode(local.policy_notebook_17)
}

resource "databricks_permissions" "can_use_notebook_17" {
  count             = contains(var.supported_databricks_major_versions, "17") ? 1 : 0
  cluster_policy_id = databricks_cluster_policy.notebook_17[0].id
  access_control {
    group_name       = "users"
    permission_level = "CAN_USE"
  }
}

resource "databricks_cluster_policy" "job_17" {
  count      = contains(var.supported_databricks_major_versions, "17") ? 1 : 0
  name       = "aware-job-17"
  definition = jsonencode(local.policy_job_17)
}

resource "databricks_permissions" "can_use_job_17" {
  count             = contains(var.supported_databricks_major_versions, "17") ? 1 : 0
  cluster_policy_id = databricks_cluster_policy.job_17[0].id
  access_control {
    group_name       = "users"
    permission_level = "CAN_USE"
  }
}


locals {
  policy_job_17 = merge(
    local.default_log_policy,
    local.default_tags_policy,
    local.default_spark_policy,
    local.default_databricks_configuration,
    local.default_docker_policy,
    local.default_job_policy,
    local.pool_policies_values,
    var.user_and_jobs_are_unrestricted ? {} : local.default_restricted_policy,
    local.policy_overrides_17,
  )

  policy_notebook_17 = merge(
    local.default_log_policy,
    local.default_tags_policy,
    local.default_spark_policy,
    local.default_databricks_configuration_notebook,
    local.default_docker_policy,
    local.default_notebook_policy,
    var.user_and_jobs_are_unrestricted ? {} : local.default_restricted_policy,
    local.policy_overrides_17,
  )

  policy_overrides_17 = {
    "custom_tags.ADBX_RUNTIME" = {
      hidden = false
      type   = "fixed"
      value  = "17"
    }
    spark_version = {
      hidden = false
      type   = "fixed"
      value  = "17.3.x-scala2.13"
    }
    data_security_mode = {
      hidden = false
      type   = "fixed"
      value  = "DATA_SECURITY_MODE_DEDICATED"
    }
    "docker_image.url" = {
      hidden = false
      type   = "fixed"
      value  = "${var.acr_url}/databricks17:${lower(var.environment)}-current"
    }
  }
}
