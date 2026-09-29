# tflint-ignore: terraform_unused_declarations
variable "workspace_id" {
  type        = string
  description = "The Databricks workspace Azure ID."
  default     = "empty"
}

# tflint-ignore: terraform_unused_declarations
variable "workspace_url" {
  type        = string
  description = "The Databricks workspace URL."
  default     = "empty"
}

# tflint-ignore: terraform_unused_declarations
variable "disaster_recovery" {
  type        = bool
  description = "disaster recovery infrastructure?"
  default     = false
}

variable "telemetry_connection_string" {
  type        = string
  description = "The connection string to the telemetry."
  default     = "telemetry_not_set"
}

variable "data_scope" {
  type = string
  validation {
    condition     = contains(["AWARE", "ITM", "LDIT", "MANAGEMENT", "NONE"], upper(var.data_scope))
    error_message = "${var.data_scope} is not a valid scope (AWARE, ITM, LDIT) or tech scope MANAGEMENT"
  }
  description = "The data scope of the Databricks workspace. It is used to determine the permissions."
  default     = "NONE"
}

variable "environment" {
  type        = string
  description = "The infrastructure environment."
}

variable "user_and_jobs_are_unrestricted" {
  type        = bool
  description = "Indicates if users and jobs are unrestricted."
  default     = false
}

variable "key_vault_id" {
  type        = string
  description = "The key vault id."
}

variable "trigram" {
  type        = string
  description = "The project trigram."
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID."
  default     = "8ca5b849-53e1-48cf-89fb-0103886af200"
}

variable "acr_url" {
  type        = string
  description = "The Azure Container Registry and repository holding this project's images."
}

variable "current_databricks_major_version" {
  type        = string
  description = "The Databricks runtime major version (e.g. \"17\") used to select the \"current\" cluster policies."
  default     = "17"
}

variable "supported_databricks_major_versions" {
  type        = list(string)
  description = "The list of supported Databricks runtime major versions."
  default     = ["15", "17", "18"]
}

variable "additional_allowed_instance_pool_ids" {
  description = "Extra instance pool IDs allowed by the job cluster policy, on top of this module's own pools."
  type = object({
    driver    = list(string)
    all_nodes = list(string)
  })
  default = null
}

variable "enable_flyway_warehouse" {
  description = "Create a dedicated sql warehouse for running flyway migrations"
  type        = bool
  default     = false
}

variable "disable_legacy_hive_metastore" {
  description = "Indicates if the legacy Hive metastore should be disabled."
  type        = bool
  default     = true
}

variable "default_catalog" {
  description = "The default Unity Catalog for the Databricks workspace. MUST BE SET BEFORE DISABLE HIVE"
  type        = string
}

variable "disable_legacy_dbfs" {
  description = "Indicates if the legacy DBFS should be disabled."
  type        = bool
  default     = true
}
