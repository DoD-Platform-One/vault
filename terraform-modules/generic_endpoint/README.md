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
| data\_json | (Required) String containing a JSON-encoded object that will be written to the given path as the secret data. | `string` | `""` | no |
| ignore\_absent\_fields | (Optional) True/false. If set to true, ignore any fields present when the endpoint is read but that were not in data\_json | `bool` | `true` | no |
| path | (Required) The full logical path at which to write the given data. Consult each backend's documentation to see which endpoints support the PUT methods and to determine whether they also support DELETE and GET. | `string` | `""` | no |
| write\_fields | (Optional) A list of fields that should be returned in write\_data\_json and write\_data. If omitted, data returned by the write operation is not available to the resource or included in state. This helps to avoid accidental storage of sensitive values in state. Some endpoints, such as many dynamic secrets endpoints, return data from writing to an endpoint rather than reading it. You should use write\_fields if you need information returned in this way. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | path modified |
| path | path modified |

