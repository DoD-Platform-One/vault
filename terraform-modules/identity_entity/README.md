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
| identity\_entity\_name | (Required) Name of the identity entity to create | `string` | n/a | yes |
| identity\_entity\_policies | (Optional) A list of policies to apply to the entity | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The id of the created identity\_entity |
| identity\_entity\_name | The name of the created identity\_entity |

