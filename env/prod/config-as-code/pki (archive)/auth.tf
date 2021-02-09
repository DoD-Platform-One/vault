# mount point for auth
resource "vault_mount" "auth" {
  path                  = "pki/auth"
  type                  = "pki"
  max_lease_ttl_seconds = 94608000 # 3 years
  seal_wrap                = true
  external_entropy_access  = true
}

# generate p1 auth csr
resource "vault_pki_secret_backend_intermediate_cert_request" "auth" {
  backend = vault_mount.auth.path

  type        = "internal"
  common_name = "DoD P1 Authentication Intermediate CA"
  key_type    = "rsa"
  key_bits    = "4096"

  country      = "US"
  organization = "U.S. Government"
  ou           = "DoD PKI"
}

# sign auth csr with p1 int ca
resource "vault_pki_secret_backend_root_sign_intermediate" "auth" {
  backend = vault_mount.pki_p1_int.path

  csr                  = vault_pki_secret_backend_intermediate_cert_request.auth.csr
  common_name          = "Cert Authentication"
  ttl                  = "43800h"
  exclude_cn_from_sans = true
}

# store signed auth int ca
resource "vault_pki_secret_backend_intermediate_set_signed" "auth" {
  backend = vault_mount.auth.path

  certificate = vault_pki_secret_backend_root_sign_intermediate.auth.certificate
}

# create role
resource "vault_pki_secret_backend_role" "auth_leaf" {
  backend            = vault_mount.auth.path
  name               = "auth-leaf-cert" # name of role
  allowed_domains    = ["ident.dso.mil"] 
  allow_subdomains   = true
  allow_bare_domains = false
  allow_glob_domains = false
  enforce_hostnames  = false
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
