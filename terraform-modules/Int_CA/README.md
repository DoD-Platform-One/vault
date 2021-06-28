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
| [vault_mount](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) |
| [vault_pki_secret_backend_config_urls](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/pki_secret_backend_config_urls) |
| [vault_pki_secret_backend_crl_config](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/pki_secret_backend_crl_config) |
| [vault_pki_secret_backend_intermediate_cert_request](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/pki_secret_backend_intermediate_cert_request) |
| [vault_pki_secret_backend_intermediate_set_signed](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/pki_secret_backend_intermediate_set_signed) |
| [vault_pki_secret_backend_root_sign_intermediate](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/pki_secret_backend_root_sign_intermediate) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ca\_chain | (Required) List of signed certificates in CA chain | `string` | `""` | no |
| crl\_url | (Optional) Specifies the URL values for the CRL Distribution Points field | `list` | <pre>[<br>  ""<br>]</pre> | no |
| default\_mount\_ttl | (Optional) Default lease duration for tokens and secrets in seconds | `number` | n/a | yes |
| description | (Optional) Human-friendly description of the mount | `string` | `""` | no |
| disable\_crl | (Optional) Disables or enables CRL building | `bool` | `false` | no |
| expiry | (Optional) Specifies the time until expiration | `string` | `"72h"` | no |
| external\_entropy | (Optional) Boolean flag that can be explicitly set to true to enable the secrets engine to access Vault's external entropy source | `bool` | `true` | no |
| int\_mount\_path | (Required) The PKI secret backend that will sign the csr | `string` | `""` | no |
| intermediate\_ca\_csr\_cn | (Required) CN of intermediate to create | `string` | `""` | no |
| max\_mount\_ttl | (Optional) Maximum possible lease duration for tokens and secrets in seconds | `number` | n/a | yes |
| mount\_path | Where the secret backend will be mounted | `string` | `""` | no |
| mount\_type | Type of the backend, such as 'aws', 'pki', 'kv', etc. | `string` | `""` | no |
| ocsp\_svrs | (Optional) Specifies the URL values for the Issuing Certificate field | `list` | <pre>[<br>  ""<br>]</pre> | no |
| seal\_wrap | (Optional) Boolean flag that can be explicitly set to true to enable seal wrapping for the mount, causing values stored by the mount to be wrapped by the seal's encryption capability | `bool` | `true` | no |
| signed\_cert | turnary operator to skip vault sign functions for int CA which will be signed by offline root CA | `bool` | `true` | no |
| signed\_cert\_and\_ca\_chain | (Required) The signed certificate and appended ca chain in pem format | `string` | `""` | no |
| vault\_signed\_CA | turnary operator to pause / skip unnecessary functions for int CA which will be signed by offline root CA | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| crl\_endpoint | Specifies the URL values for the CRL Distribution Points field |
| crl\_id | (Required) The path the PKI secret backend is mounted at, with no leading or trailing /s |
| csr | Output the certificate signing request for external / offline CA signing |
| path | Where the secret backend will be mounted |
| signed\_cert | Output the signed certificate |
