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
provider "vault" {}

resource "vault_mount" "pki_root" {
  path                  = "pki_root"
  type                  = "pki"
  max_lease_ttl_seconds = 315360000 # 10 years
}

resource "vault_pki_secret_backend_root_cert" "pki_root" {
  backend = vault_mount.pki_root.path

  type                 = "internal"
  common_name          = "Vault Root Certificate Authority"
  ttl                  = "87600h"
  key_type             = "rsa"
  key_bits             = 4096
  exclude_cn_from_sans = true
}

resource "vault_mount" "pki_int" {
  path                  = "pki_int"
  type                  = "pki"
  max_lease_ttl_seconds = 157680000 # 5 years
}

resource "vault_pki_secret_backend_intermediate_cert_request" "pki_int" {
  backend = vault_mount.pki_int.path

  type        = "internal"
  common_name = "Vault Intermediate Authority"
  key_type    = "rsa"
  key_bits    = "4096"
}

resource "vault_pki_secret_backend_root_sign_intermediate" "pki_int" {
  backend = vault_mount.pki_root.path

  csr                  = vault_pki_secret_backend_intermediate_cert_request.pki_int.csr
  common_name          = "Vault Intermediate Authority"
  ttl                  = "43800h"
  exclude_cn_from_sans = true
}

resource "vault_pki_secret_backend_intermediate_set_signed" "pki_int" {
  backend = vault_mount.pki_int.path

  certificate = vault_pki_secret_backend_root_sign_intermediate.pki_int.certificate
}

resource "vault_pki_secret_backend_role" "leaf" {
  backend            = vault_mount.pki_int.path
  name               = "leaf-cert"
  allowed_domains    = ["example.io"] 
  allow_bare_domains = false          #
  allow_subdomains   = true           #
  allow_glob_domains = false          #
  allow_any_name     = false          # adjust allow_*, flags accordingly
  allow_ip_sans      = false          #
  server_flag        = true           #
  client_flag        = true           #

  max_ttl            = "730h"         # ~1 month
  ttl                = "730h"
}

output "leaf" {
  value = "genertate cert with `vault write pki_int/issue/leaf-cert common_name=demo.example.io`"
}