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
| enforcement\_level | (Required) Enforcement level of Sentinel policy. Can be either 'advisory' or 'soft-mandatory' or 'hard-mandatory' | `string` | `""` | no |
| name | (Required) The name of the policy | `string` | `""` | no |
| paths | (Required) List of paths to which the policy will be applied to | `list` | `""` | no |
| policy | (Required) String containing a Sentinel policy | `string` | `""` | no |

## Outputs

No output.

