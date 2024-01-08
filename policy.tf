resource "databricks_cluster_policy" "fair_use" {
  name       = "Analysts cluster policy"
  definition = jsonencode(local.merged_policy)
}

resource "databricks_permissions" "can_use_cluster_policyinstance_profile" {
  cluster_policy_id = databricks_cluster_policy.fair_use.id
  access_control {
    group_name       = "analysts"
    permission_level = "CAN_USE"
  }
}

locals {
  merged_policy = merge(local.default_policy, var.policy_overrides, local.log_policy)

  # If a log_name was provided, define the log policy.
  log_policy = length(var.logs_path) > 0 ? local.log_policy_template : {}

  default_policy = {

    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 45,
      "hidden" : false
    },
    "spark_version" : {
      "type" : "allowlist",
      "values" : ["12.2.x-scala2.12", "13.3.x-scala2.12"]
      "hidden" : false
    },
    "docker_image.url" : {
      "type" : "forbidden",
      "hidden" : true
    },
    "init_scripts.0.dbfs.destination" : {
      "type" : "fixed",
      "value" : "dbfs:/init/init_aware_cluster.sh"
      "hidden" : false
    },
    "data_security_mode" : {
      "type" : "fixed",
      "value" : "NONE",
      "hidden" : false
    },
    "azure_attributes.availability" : {
      "type" : "fixed",
      "value" : "SPOT_WITH_FALLBACK_AZURE",
      "hidden" : false
    },
    "autoscale.min_workers" : {
      "type" : "unlimited",
      "defaultValue" : 1
    },
    "autoscale.max_workers" : {
      "type" : "unlimited",
      "defaultValue" : 2
    },
    "custom_tags.policy" : {
      "type" : "fixed",
      "value" : "analysts"
    }
  }

  log_policy_template = {
    "cluster_log_conf.type" : {
      "type" : "fixed",
      "value" : "DBFS",
      "hidden" : false
    },
    "cluster_log_conf.path" : {
      "type" : "fixed",
      "value" : "${var.logs_path}",
      "hidden" : false
    }
  }
}
