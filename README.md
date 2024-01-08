# Azure Aware Databricks Config

[![Build Status](https://dev.azure.com/weareretail/Tooling/_apis/build/status/mod_azu_databricks?repoName=mod_azu_databricks_config&branchName=master)](https://dev.azure.com/weareretail/Tooling/_build/latest?definitionId=11&repoName=mod_azu_databricks_config&branchName=master)[![Unilicence](https://img.shields.io/badge/licence-The%20Unilicence-green)](LICENCE)

Common Azure Terraform module to normalize Azure Databricks config setup.

# Usage

```hcl
module "databricks_config" {
  source = "./modules/mod_azu_databricks_config"

  admin_group  = "GRP_SEC_ADMINS"
  user_group   = "GRP_SEC_USERS"
  read_group   = "GRP_SEC_READ"
  key_vault_id = one(data.azurerm_resources.kv_application_main.resources[*].id)
}
```

***Autogenerated file - do not edit***

#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement\_azurecaf) | >= 1.2.16 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.2 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | >= 1.0.0 |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_group"></a> [admin\_group](#input\_admin\_group) | Administrators user group (with no groups inside). | `string` | n/a | yes |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | n/a | `string` | n/a | yes |
| <a name="input_read_group"></a> [read\_group](#input\_read\_group) | Read only users user group (with no groups inside). | `string` | n/a | yes |
| <a name="input_user_group"></a> [user\_group](#input\_user\_group) | Developpers user group (with no groups inside). | `string` | n/a | yes |
| <a name="input_logs_path"></a> [logs\_path](#input\_logs\_path) | The clusters logs root folder. | `string` | `""` | no |
| <a name="input_policy_overrides"></a> [policy\_overrides](#input\_policy\_overrides) | Cluster policy overrides | `map` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | Tenand ID. | `string` | `"8ca5b849-53e1-48cf-89fb-0103886af200"` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_analyst_group_name"></a> [analyst\_group\_name](#output\_analyst\_group\_name) | n/a |
| <a name="output_databricks_group_analysts"></a> [databricks\_group\_analysts](#output\_databricks\_group\_analysts) | Databricks Analysts group. |
| <a name="output_read_group_name"></a> [read\_group\_name](#output\_read\_group\_name) | n/a |
| <a name="output_security_scope"></a> [security\_scope](#output\_security\_scope) | Databricks security scope name. |
| <a name="output_spn_id_value"></a> [spn\_id\_value](#output\_spn\_id\_value) | SPN ID value |
| <a name="output_spn_secret_key"></a> [spn\_secret\_key](#output\_spn\_secret\_key) | SPN Secret key. |

<!-- BEGIN_TF_DOCS -->
#### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement\_azurecaf) | >= 1.2.16 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.2 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | >= 1.0.0 |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_group"></a> [admin\_group](#input\_admin\_group) | Administrators user group (with no groups inside). | `string` | n/a | yes |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | n/a | `string` | n/a | yes |
| <a name="input_read_group"></a> [read\_group](#input\_read\_group) | Read only users user group (with no groups inside). | `string` | n/a | yes |
| <a name="input_user_group"></a> [user\_group](#input\_user\_group) | Developpers user group (with no groups inside). | `string` | n/a | yes |
| <a name="input_logs_path"></a> [logs\_path](#input\_logs\_path) | The clusters logs root folder. | `string` | `""` | no |
| <a name="input_policy_overrides"></a> [policy\_overrides](#input\_policy\_overrides) | Cluster policy overrides | `map` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | Tenand ID. | `string` | `"8ca5b849-53e1-48cf-89fb-0103886af200"` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_analyst_group_name"></a> [analyst\_group\_name](#output\_analyst\_group\_name) | n/a |
| <a name="output_databricks_group_analysts"></a> [databricks\_group\_analysts](#output\_databricks\_group\_analysts) | Databricks Analysts group. |
| <a name="output_read_group_name"></a> [read\_group\_name](#output\_read\_group\_name) | n/a |
| <a name="output_security_scope"></a> [security\_scope](#output\_security\_scope) | Databricks security scope name. |
| <a name="output_spn_id_value"></a> [spn\_id\_value](#output\_spn\_id\_value) | SPN ID value |
| <a name="output_spn_secret_key"></a> [spn\_secret\_key](#output\_spn\_secret\_key) | SPN Secret key. |
<!-- END_TF_DOCS -->