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
| default\_mount\_ttl | (Optional) Default lease duration for tokens and secrets in seconds | `string` | `""` | no |
| description | (Optional) Human-friendly description of the mount | `string` | `""` | no |
| external\_entropy | (Optional) Boolean flag that can be explicitly set to true to enable the secrets engine to access Vault's external entropy source | `bool` | `true` | no |
| max\_mount\_ttl | (Optional) Maximum possible lease duration for tokens and secrets in seconds | `string` | `""` | no |
| mount\_path | Where the secret backend will be mounted | `string` | `""` | no |
| mount\_type | Type of the backend, such as 'aws', 'pki', 'kv', etc. | `string` | `""` | no |
| seal\_wrap | (Optional) Boolean flag that can be explicitly set to true to enable seal wrapping for the mount, causing values stored by the mount to be wrapped by the seal's encryption capability | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| path | Where the secret backend will be mounted |

