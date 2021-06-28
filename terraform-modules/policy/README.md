## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.4 |
| vault | >= 2.17.0 |

## Providers

| Name | Version |
|------|---------|
| vault | >= 2.17.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | (Required) The name of the policy | `string` | `""` | no |
| policy | (Required) String containing a Vault policy | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| policy | Output the policy |

