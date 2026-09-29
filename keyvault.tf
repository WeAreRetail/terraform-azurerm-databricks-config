# Retrieve the secrets from Azure Key Vault

data "azurerm_key_vault_secrets" "keyvault_secrets" {
  key_vault_id = var.key_vault_id
}
