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
| userpass\_mount\_accessor | (Required) Accessor of the mount to which the alias should belong to | `string` | n/a | yes |
| userpass\_username | (Required) Name of the alias. Name should be the identifier of the client in the authentication source | `string` | n/a | yes |

## Outputs

No output.

