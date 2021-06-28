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
| description | (Optional) Boolean flag that can be explicitly set to true to enable seal wrapping for the mount, causing values stored by the mount to be wrapped by the seal's encryption capability | `string` | n/a | yes |
| local | (Optional) Human-friendly description of the mount | `bool` | n/a | yes |
| options | (Optional) Maximum possible lease duration for tokens and secrets in seconds | `map` | n/a | yes |
| path | (Optional) Human-friendly description of the audit device. | `string` | n/a | yes |
| type | (Required) Type of the audit device, such as 'file'. | `string` | n/a | yes |

## Outputs

No output.

