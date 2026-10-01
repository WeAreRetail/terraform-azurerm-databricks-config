resource "databricks_cluster_policy" "notebook_current" {
  name       = "aware-notebook-current"
  definition = jsonencode(local.policy_notebook_by_version[var.current_databricks_major_version])
}

resource "databricks_permissions" "can_use_notebook_current" {
  cluster_policy_id = databricks_cluster_policy.notebook_current.id
  access_control {
    group_name       = "users"
    permission_level = "CAN_USE"
  }
}

resource "databricks_cluster_policy" "job_current" {
  name       = "aware-job-current"
  definition = jsonencode(local.policy_job_by_version[var.current_databricks_major_version])
}

resource "databricks_permissions" "can_use_job_current" {
  cluster_policy_id = databricks_cluster_policy.job_current.id
  access_control {
    group_name       = "users"
    permission_level = "CAN_USE"
  }
}

locals {
  # maps of major version -> policy definition, keyed to select the "current" policy above
  policy_job_by_version = {
    "18" = local.policy_job_18
    "17" = local.policy_job_17
    "15" = local.policy_job_15
  }
  policy_notebook_by_version = {
    "18" = local.policy_notebook_18
    "17" = local.policy_notebook_17
    "15" = local.policy_notebook_15
  }

  # per major version overrides, shared by the job and the notebook policies of that version
  policy_overrides_by_version = {
    "18" = local.policy_overrides_18
    "17" = local.policy_overrides_17
    "15" = local.policy_overrides_15
  }

  # Read from the version overrides, not from the merged policies: the merged job policies depend on
  # var.additional_allowed_instance_pool_ids, and these outputs feed the pools given back in that variable
  # (instance pools preloading the policy runtime and image): reading the merged policies would be a cycle.
  current_policy_spark_version    = local.policy_overrides_by_version[var.current_databricks_major_version]["spark_version"].value
  current_policy_docker_image_url = local.policy_overrides_by_version[var.current_databricks_major_version]["docker_image.url"].value
}

locals {
  # DBFS cluster_log_conf disabled: it caused driver startup timeouts on this workspace
  default_log_policy = {}

  default_databricks_configuration = {

    runtime_engine = {
      hidden = false
      type   = "fixed"
      value  = "STANDARD"
    }
    use_ml_runtime = {
      hidden = false
      type   = "fixed"
      value  = false
    }
  }

  # autotermination_minutes is only valid on all-purpose clusters, not on job clusters
  default_databricks_configuration_notebook = merge(
    local.default_databricks_configuration,
    {
      autotermination_minutes = {
        type  = "fixed"
        value = 30
      }
    }
  )

  default_docker_policy = {
    "docker_image.basic_auth.password" = {
      type   = "fixed"
      value  = "{{secrets/registry/acr-password}}"
      hidden = true
    }
    "docker_image.basic_auth.username" = {
      hidden = false
      type   = "fixed"
      value  = "{{secrets/registry/acr-username}}"
    }
  }

  default_restricted_policy = {
    dbus_per_hour = {
      type     = "range"
      maxValue = 10
    }
  }

  default_spark_policy = {
    "spark_env_vars.LANG" : {
      "type" : "fixed",
      "value" : "C.UTF-8",
      "hidden" : false
    },
    "spark_env_vars.LC_ALL" : {
      "type" : "fixed",
      "value" : "C.UTF-8",
      "hidden" : false
    },
    "spark_conf.spark.databricks.unityCatalog.volumes.enabled" : {
      "type" : "fixed",
      "value" : "true",
      "hidden" : false
    }
  }

  default_tags_policy = {
    "custom_tags.ADB_TRIGRAM" : {
      "type" : "fixed",
      "value" : upper(var.trigram),
      "hidden" : false
    }
  }

  default_notebook_policy = {
    "custom_tags.ADBX_ROLE" = {
      hidden = false
      type   = "fixed"
      value  = "NOTEBOOK"
    }
    "workload_type.clients.notebooks" = {
      type  = "fixed"
      value = true
    }
    "workload_type.clients.jobs" = {
      hidden = false
      type   = "fixed"
      value  = false
    }
    cluster_type = {
      hidden = false
      type   = "fixed"
      value  = "all-purpose"
    },
    "azure_attributes.availability" = {
      hidden = false
      type   = "fixed"
      value  = "SPOT_WITH_FALLBACK_AZURE"
    },
  }

  default_job_policy = {
    "custom_tags.ADBX_ROLE" = {
      hidden = false
      type   = "fixed"
      value  = "JOB"
    }
    "workload_type.clients.notebooks" = {
      type   = "fixed"
      value  = false
      hidden = false
    }
    "workload_type.clients.jobs" = {
      hidden = false
      type   = "fixed"
      value  = true
    }
    cluster_type = {
      hidden = false
      type   = "fixed"
      value  = "job"
    }
  }

  pool_policies_values = merge(
    var.additional_allowed_instance_pool_ids != null ? {} : {
      "azure_attributes.availability" = {
        hidden = false
        type   = "fixed"
        value  = "SPOT_WITH_FALLBACK_AZURE"
      }
    },
    var.additional_allowed_instance_pool_ids == null ? {} : {
      # Workers on spot or warm, driver always on warm: a preempted worker is re-acquired,
      # a preempted driver kills the run. Warm workers are allowed so a job can retry an
      # on-demand tier after a spot run fails; choosing the tier is left to each bundle.
      "instance_pool_id" = {
        hidden = false
        type   = "allowlist"
        values = var.additional_allowed_instance_pool_ids.all_nodes
      }
      "driver_instance_pool_id" = {
        hidden = false
        type   = "allowlist"
        values = var.additional_allowed_instance_pool_ids.driver
      }
    },
  )
}
