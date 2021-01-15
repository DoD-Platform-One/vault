# mount point for p1 root ca
resource "vault_mount" "p1_pki_root" {
  path                  = "p1_pki_root"
  type                  = "pki"
  max_lease_ttl_seconds = 94608000 # 3 years
  seal_wrap                = true
  external_entropy_access  = true
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
  seal_wrap                = true
  external_entropy_access  = true
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

# create role
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
  key_usage          = [
      "DigitalSignature",
      "KeyAgreement",
      "KeyEncipherment",
  ]
  max_ttl            = "2628000"         # ~1 month
  ttl                = "2628000"
}