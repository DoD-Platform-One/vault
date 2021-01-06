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
provider "vault" {
  address = "https://127.0.0.1:8200"
  skip_tls_verify = true
}
# mount point for p1 root ca
resource "vault_mount" "p1_pki_root" {
  path                  = "p1_pki_root"
  type                  = "pki"
  max_lease_ttl_seconds = 94608000 # 3 years
}
# generate p1 root ca
resource "vault_pki_secret_backend_root_cert" "p1_pki_root" {
  backend = vault_mount.p1_pki_root.path

  type                 = "internal"
  common_name          = "DoD P1 Root Certificate Authority"
  ttl                  = "87600h"
  key_type             = "rsa"
  key_bits             = 4096
  exclude_cn_from_sans = true
}
# mount point for p1 intermediate ca
resource "vault_mount" "p1_pki_int" {
  path                  = "p1_pki_int"
  type                  = "pki"
  max_lease_ttl_seconds = 94608000 # 3 years
}
# generate p1 int ca csr
resource "vault_pki_secret_backend_intermediate_cert_request" "p1_pki_int" {
  backend = vault_mount.p1_pki_int.path

  type        = "internal"
  common_name = "DoD P1 Intermediate Certificate Authority"
  key_type    = "rsa"
  key_bits    = "4096"
}
# sign p1 int with root ca
resource "vault_pki_secret_backend_root_sign_intermediate" "p1_pki_int" {
  backend = vault_mount.p1_pki_root.path

  csr                  = vault_pki_secret_backend_intermediate_cert_request.p1_pki_int.csr
  common_name          = "DoD P1 Intermediate Certificate Authority"
  ttl                  = "43800h"
  exclude_cn_from_sans = true
}
# store signed p1 int ca
resource "vault_pki_secret_backend_intermediate_set_signed" "p1_pki_int" {
  backend = vault_mount.p1_pki_int.path

  certificate = vault_pki_secret_backend_root_sign_intermediate.p1_pki_int.certificate
}
# mount point for il2 p1 intermediate ca
resource "vault_mount" "il2_p1_pki_int" {
  path                  = "il2_p1_pki_int"
  type                  = "pki"
  max_lease_ttl_seconds = 94608000 # 3 years
}
# generate p1 il2 csr
resource "vault_pki_secret_backend_intermediate_cert_request" "il2_p1_pki_int" {
  backend = vault_mount.il2_p1_pki_int.path

  type        = "internal"
  common_name = "DoD P1 IL2 Intermediate Certificate Authority"
  key_type    = "rsa"
  key_bits    = "4096"
}
# sign il2 csr with p1 int ca
resource "vault_pki_secret_backend_root_sign_intermediate" "il2_p1_pki_int" {
  backend = vault_mount.p1_pki_int.path

  csr                  = vault_pki_secret_backend_intermediate_cert_request.il2_p1_pki_int.csr
  common_name          = "DoD P1 IL2 Intermediate Certificate Authority"
  ttl                  = "43800h"
  exclude_cn_from_sans = true
}
# store signed il2 p1 int ca
resource "vault_pki_secret_backend_intermediate_set_signed" "il2_p1_pki_int" {
  backend = vault_mount.il2_p1_pki_int.path

  certificate = vault_pki_secret_backend_root_sign_intermediate.il2_p1_pki_int.certificate
}
# mount point for il4 p1 intermediate ca
resource "vault_mount" "il4_p1_pki_int" {
  path                  = "il4_p1_pki_int"
  type                  = "pki"
  max_lease_ttl_seconds = 94608000 # 3 years
}
# generate p1 il4 csr
resource "vault_pki_secret_backend_intermediate_cert_request" "il4_p1_pki_int" {
  backend = vault_mount.il4_p1_pki_int.path

  type        = "internal"
  common_name = "DoD P1 IL4 Intermediate Certificate Authority"
  key_type    = "rsa"
  key_bits    = "4096"
}
# sign il4 csr with p1 int ca
resource "vault_pki_secret_backend_root_sign_intermediate" "il4_p1_pki_int" {
  backend = vault_mount.p1_pki_int.path

  csr                  = vault_pki_secret_backend_intermediate_cert_request.il4_p1_pki_int.csr
  common_name          = "DoD P1 IL4 Intermediate Certificate Authority"
  ttl                  = "43800h"
  exclude_cn_from_sans = true
}
# store signed il4 p1 int ca
resource "vault_pki_secret_backend_intermediate_set_signed" "il4_p1_pki_int" {
  backend = vault_mount.il4_p1_pki_int.path

  certificate = vault_pki_secret_backend_root_sign_intermediate.il4_p1_pki_int.certificate
}
# mount point for il5 p1 intermediate ca
resource "vault_mount" "il5_p1_pki_int" {
  path                  = "il5_p1_pki_int"
  type                  = "pki"
  max_lease_ttl_seconds = 94608000 # 3 years
}
# generate p1 il5 csr
resource "vault_pki_secret_backend_intermediate_cert_request" "il5_p1_pki_int" {
  backend = vault_mount.il5_p1_pki_int.path

  type        = "internal"
  common_name = "DoD P1 IL5 Intermediate Certificate Authority"
  key_type    = "rsa"
  key_bits    = "4096"
}
# sign il5 csr with p1 int ca
resource "vault_pki_secret_backend_root_sign_intermediate" "il5_p1_pki_int" {
  backend = vault_mount.p1_pki_int.path

  csr                  = vault_pki_secret_backend_intermediate_cert_request.il5_p1_pki_int.csr
  common_name          = "DoD P1 IL5 Intermediate Certificate Authority"
  ttl                  = "43800h"
  exclude_cn_from_sans = true
}
# store signed il5 p1 int ca
resource "vault_pki_secret_backend_intermediate_set_signed" "il5_p1_pki_int" {
  backend = vault_mount.il5_p1_pki_int.path

  certificate = vault_pki_secret_backend_root_sign_intermediate.il5_p1_pki_int.certificate
}

resource "vault_pki_secret_backend_role" "p1_pki_int_leaf" {
  backend            = vault_mount.p1_pki_int.path
  name               = "p1-leaf-cert" # name of role
  allowed_domains    = ["dso.mil"] 
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

output "p1_pki_int_leaf" {
  value = "genertate cert with `vault write pki_int/issue/leaf-cert common_name=dso.mil`"
}

resource "vault_pki_secret_backend_role" "il2_p1_pki_int_leaf" {
  backend            = vault_mount.il2_p1_pki_int.path
  name               = "il2-p1-leaf-cert" # name of role
  allowed_domains    = ["il2.dso.mil"] 
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

output "il2_p1_pki_int_leaf" {
  value = "genertate cert with `vault write pki_int/issue/leaf-cert common_name=il2.dso.mil`"
}

resource "vault_pki_secret_backend_role" "il4_p1_pki_int_leaf" {
  backend            = vault_mount.il4_p1_pki_int.path
  name               = "il4-p1-leaf-cert" # name of role
  allowed_domains    = ["il4.dso.mil"] 
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

output "il4_p1_pki_int_leaf" {
  value = "genertate cert with `vault write pki_int/issue/leaf-cert common_name=il4.dso.mil`"
}

resource "vault_pki_secret_backend_role" "il5_p1_pki_int_leaf" {
  backend            = vault_mount.il5_p1_pki_int.path
  name               = "il5-p1-leaf-cert" # name of role
  allowed_domains    = ["il5.dso.mil"] 
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

output "il5_p1_pki_int_leaf" {
  value = "genertate cert with `vault write pki_int/issue/leaf-cert common_name=il5.dso.mil`"
}