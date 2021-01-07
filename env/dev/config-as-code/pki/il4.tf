# mount point for il4 p1 intermediate ca
resource "vault_mount" "il4_p1_pki_int" {
  path                  = "il4_p1_pki_int"
  type                  = "pki"
  max_lease_ttl_seconds = 94608000 # 3 years
  options               = {
    seal_wrap                = true
    external_entropy_access  = true
  }
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
# create role
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
  key_usage          = [
      "DigitalSignature",
      "KeyAgreement",
      "KeyEncipherment",
  ]
  max_ttl            = "2628000"         # ~1 month
  ttl                = "2628000"
}
