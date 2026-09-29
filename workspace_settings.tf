
# Tips
# To get the setting names, open the Dev Tools while browsing
# the settings on the web interface. Toggle a setting and look at the
# call to workspace-conf

resource "databricks_workspace_conf" "workspace_conf" {
  custom_config = {
    "enableDbfsFileBrowser"                     = false
    "enableDcs"                                 = true # Container services (Docker)
    "enableExportNotebook"                      = false
    "enableWebTerminal"                         = false
    "enableFileStoreEndpoint"                   = false
    "enableTokensConfig"                        = false
    "enableDeprecatedGlobalInitScripts"         = false
    "enableDeprecatedClusterNamedInitScripts"   = false
    "enableResultsDownloading"                  = false
    "enableUploadDataUis"                       = false
    "enableNotebookTableClipboard"              = false
    "enforceUserIsolation"                      = true
    "mlflowModelServingEndpointCreationEnabled" = false
    "customerApprovedWSLoginExpirationTime"     = "1998-01-01T00:00:00.000Z"
  }
}

## Legacy Access Settings

resource "databricks_disable_legacy_access_setting" "this" {
  disable_legacy_access {
    value = var.disable_legacy_hive_metastore
  }

  depends_on = [databricks_default_namespace_setting.default_catalog]
}

resource "databricks_disable_legacy_dbfs_setting" "this" {
  disable_legacy_dbfs {
    value = var.disable_legacy_dbfs
  }
}

resource "databricks_default_namespace_setting" "default_catalog" {
  namespace {
    value = var.default_catalog # e.g. "main" or "prd_gold", anything except "hive_metastore"
  }
}


###############################################################
# PREVIEW
###############################################################

resource "databricks_workspace_setting_v2" "embedded_genie" {
  name = "embedded_genie"
  boolean_val = {
    value = false
  }
}

## DCS vnext - DCS With standard mode
resource "databricks_workspace_setting_v2" "enable_dcs_vnext" {
  name = "enable_dcs_vnext"
  boolean_val = {
    value = true
  }
}

resource "databricks_workspace_setting_v2" "dbsql_5xl_pro" {
  name = "dbsql_5xl_pro"
  boolean_val = {
    value = false
  }
}

resource "databricks_workspace_setting_v2" "dbsql_5xl_serverless" {
  name = "dbsql_5xl_serverless"
  boolean_val = {
    value = false
  }
}

resource "databricks_workspace_setting_v2" "aibi_dashboard_relationships" {
  name = "aibi_dashboard_relationships"
  boolean_val = {
    value = false
  }
}

resource "databricks_workspace_setting_v2" "agents_obo" {
  name = "agents_obo"
  boolean_val = {
    value = false
  }
}

resource "databricks_workspace_setting_v2" "jdbc_connector" {
  name = "jdbc_connector"
  boolean_val = {
    value = true
  }
}

resource "databricks_workspace_setting_v2" "discover_page" {
  name = "discover_page"
  boolean_val = {
    value = true
  }
}

resource "databricks_workspace_setting_v2" "fmapi_qwen3_instruct" {
  name = "fmapi_qwen3_instruct"
  boolean_val = {
    value = false
  }
}

resource "databricks_workspace_setting_v2" "external_access_to_managed_delta" {
  name = "external_access_to_managed_delta"
  boolean_val = {
    value = false
  }
}

resource "databricks_workspace_setting_v2" "fstore_decl_strm_fw" {
  name = "fstore_decl_strm_fw"
  boolean_val = {
    value = false
  }
}

resource "databricks_workspace_setting_v2" "time_type" {
  name = "time_type"
  boolean_val = {
    value = true
  }
}

resource "databricks_workspace_setting_v2" "jobs_serverless_managed_base_environments" {
  name = "jobs_serverless_managed_base_environments"
  boolean_val = {
    value = true
  }
}

# resource "databricks_restrict_workspace_admins_setting" "this" {
#   restrict_workspace_admins {
#     status = "RESTRICT_TOKENS_AND_JOB_RUN_AS"
#   }
# }
