variable "admin_group" {
  type        = string
  description = "Administrators user group (with no groups inside)."
}

variable "allow_pat_config" {
  type        = bool
  description = "Whether or not to allow the usage of PATs to configure databricks"
  default     = false
}

variable "environment" {
  type        = string
  description = "The infrastructure environment."
}

variable "key_vault_id" {
  type = string
}

variable "logs_path" {
  type        = string
  description = "The clusters logs root folder."
  default     = ""
}

variable "policy_overrides" {
  description = "Cluster policy overrides"
  default     = {}
}

variable "tenant_id" {
  type        = string
  description = "Tenand ID."
  default     = "8ca5b849-53e1-48cf-89fb-0103886af200"
}

variable "trigram" {
  type        = string
  description = "The project trigram."
}

variable "read_group" {
  type        = string
  description = "Read only users user group (with no groups inside)."
}

variable "user_group" {
  type        = string
  description = "Developpers user group (with no groups inside)."
}
