terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "2.17.0"
    }
  }
}

# Set config using environment variables
# See https://registry.terraform.io/providers/hashicorp/vault/latest/docs#provider-arguments
// provider "vault" {
//   address = "https://127.0.0.1:8200"
//   skip_tls_verify = true
// }