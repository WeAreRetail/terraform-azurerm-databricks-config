#######################################################
# Well Known ACR
#######################################################

locals {
  acr_spn_id_key_name     = local.production ? "spn-databricks-prd-acr-auth-id" : "spn-databricks-npd-acr-auth-id"
  acr_spn_secret_key_name = local.production ? "spn-databricks-prd-acr-auth-secret" : "spn-databricks-npd-acr-auth-secret"

  # See keyvault.tf for the secrets retrieval
  # tflint-ignore: terraform_unused_declarations
  acr_secrets_available = alltrue([
    length([for k in data.azurerm_key_vault_secrets.keyvault_secrets.names : k if k == local.acr_spn_id_key_name]) == 1,
    length([for k in data.azurerm_key_vault_secrets.keyvault_secrets.names : k if k == local.acr_spn_secret_key_name]) == 1,
  ])
}
# Get the ACR SPN ID and secret from the Key Vault

data "azurerm_key_vault_secret" "acr_spn_id" {
  name         = local.acr_spn_id_key_name
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "acr_spn_secret" {
  name         = local.acr_spn_secret_key_name
  key_vault_id = var.key_vault_id
}

# Set the ACR SPN ID and secret in Databricks secrets

resource "databricks_secret_scope" "registry" {
  name = "registry"
}

resource "databricks_secret_acl" "registry_unity" {
  principal  = "users"
  permission = "READ"
  scope      = databricks_secret_scope.registry.name
}

resource "databricks_secret" "registry_password" {
  key          = "acr-password"
  string_value = one(data.azurerm_key_vault_secret.acr_spn_secret[*].value)
  scope        = databricks_secret_scope.registry.name

  lifecycle {
    postcondition {
      condition     = length(self.string_value) > 0
      error_message = "The ACR SPN secret is not set correctly."
    }
  }
}

resource "databricks_secret" "registry_id" {
  key          = "acr-username"
  string_value = one(data.azurerm_key_vault_secret.acr_spn_id[*].value)
  scope        = databricks_secret_scope.registry.name

  lifecycle {
    postcondition {
      condition     = length(self.string_value) > 0
      error_message = "The ACR SPN secret is not set correctly."
    }
  }
}
