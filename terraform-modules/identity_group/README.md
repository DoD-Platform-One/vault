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
| member\_entity\_ids | (Optional) A list of Entity IDs to be assigned as group members. Not allowed on external groups | `list` | <pre>[<br>  ""<br>]</pre> | no |
| name | (Required, Forces new resource) Name of the identity group to create | `string` | `""` | no |
| policies | (Optional) A list of policies to apply to the group | `list` | <pre>[<br>  "default"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| group\_members | A list of Entity IDs assigned as group members |

