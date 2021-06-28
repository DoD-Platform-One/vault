## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.4 |
| vault | >= 2.17.0 |

## Providers

| Name | Version |
|------|---------|
| vault | >= 2.17.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [vault_namespace](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/namespace) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| namespace\_path | (Required) The path of the namespace. Must not have a trailing / | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| namespace\_id | n/a |
