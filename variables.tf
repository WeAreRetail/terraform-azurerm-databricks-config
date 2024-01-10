variable "admin_group" {
  type        = string
  description = "Administrators user group (with no groups inside)."
}

variable "user_group" {
  type        = string
  description = "Developpers user group (with no groups inside)."
}

# variable "app_user_group" {
#   type        = string
#   description = "Administrators SPN group (with no groups inside)."
# }

variable "read_group" {
  type        = string
  description = "Read only users user group (with no groups inside)."
}

variable "tenant_id" {
  type        = string
  description = "Tenand ID."
  default     = "8ca5b849-53e1-48cf-89fb-0103886af200"
}

variable "policy_overrides" {
  description = "Cluster policy overrides"
  default     = {}
}

variable "key_vault_id" {
  type = string
}

variable "logs_path" {
  type        = string
  description = "The clusters logs root folder."
  default     = ""
}
