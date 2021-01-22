# mount point for il5 p1 intermediate ca
resource "vault_mount" "pki_il5_p1_int" {
  path                  = "pki/il5/p1_int"
  type                  = "pki"
  max_lease_ttl_seconds = 94608000 # 3 years
  seal_wrap                = true
  external_entropy_access  = true
}

# generate p1 il5 csr
resource "vault_pki_secret_backend_intermediate_cert_request" "pki_il5_p1_int" {
  backend = vault_mount.pki_il5_p1_int.path

  type        = "internal"
  common_name = "DoD P1 IL5 Intermediate Certificate Authority"
  key_type    = "rsa"
  key_bits    = "4096"

  country      = "US"
  province     = "Colorado"
  locality     = "Colorado Springs"
  organization = "Department of Defense"
}

# sign il5 csr with p1 int ca
resource "vault_pki_secret_backend_root_sign_intermediate" "pki_il5_p1_int" {
  backend = vault_mount.pki_p1_int.path

  csr                  = vault_pki_secret_backend_intermediate_cert_request.pki_il5_p1_int.csr
  common_name          = "DoD P1 IL5 Intermediate Certificate Authority"
  ttl                  = "43800h"
  exclude_cn_from_sans = true
}

# store signed il5 p1 int ca
resource "vault_pki_secret_backend_intermediate_set_signed" "pki_il5_p1_int" {
  backend = vault_mount.pki_il5_p1_int.path

  certificate = vault_pki_secret_backend_root_sign_intermediate.pki_il5_p1_int.certificate
}

# create role
resource "vault_pki_secret_backend_role" "pki_il5_p1_int_leaf" {
  backend            = vault_mount.pki_il5_p1_int.path
  name               = "il5-p1-leaf-cert" # name of role
  allowed_domains    = ["il5.dso.mil"] 
  allow_subdomains   = true
  allow_bare_domains = false
  allow_glob_domains = false
  enforce_hostnames  = true
  allow_any_name     = false
  allow_ip_sans      = false
  server_flag        = true
  client_flag        = true

  key_usage          = [
      "DigitalSignature",
      "KeyAgreement",
      "KeyEncipherment",
  ]
  max_ttl            = "94608000" # 3 years
  ttl                = "94608000" # 3 years
}
