# mount point for p1 root ca
resource "vault_mount" "pki_il5_p1_root" {
  path                    = "pki/il5/p1_root"
  type                    = "pki"
  max_lease_ttl_seconds   = 94608000 # 3 years
  seal_wrap               = var.enable_seal_wrap
  external_entropy_access = var.enable_external_entropy_access
}

# generate p1 root ca
resource "vault_pki_secret_backend_root_cert" "pki_il5_p1_root" {
  backend = vault_mount.pki_il5_p1_root.path

  type                 = "internal"
  common_name          = "DoD P1 Root Certificate Authority"
  ttl                  = "87600h"
  key_type             = "rsa"
  key_bits             = 4096
  exclude_cn_from_sans = true

  country      = "US"
  province     = "Colorado"
  locality     = "Colorado Springs"
  organization = "Department of Defense"
}

# mount point for p1 intermediate ca
resource "vault_mount" "pki_il5_p1_int" {
  path                    = "pki/il5/p1_int"
  type                    = "pki"
  max_lease_ttl_seconds   = 94608000 # 3 years
  seal_wrap               = var.enable_seal_wrap
  external_entropy_access = var.enable_external_entropy_access
}

# generate p1 int ca csr
resource "vault_pki_secret_backend_intermediate_cert_request" "pki_il5_p1_int" {
  backend = vault_mount.pki_il5_p1_int.path

  type        = "internal"
  common_name = "DoD P1 Intermediate Certificate Authority"
  key_type    = "rsa"
  key_bits    = "4096"

  country      = "US"
  province     = "Colorado"
  locality     = "Colorado Springs"
  organization = "Department of Defense"
}

# sign p1 int with root ca
resource "vault_pki_secret_backend_root_sign_intermediate" "pki_il5_p1_int" {
  backend = vault_mount.pki_il5_p1_root.path

  csr                  = vault_pki_secret_backend_intermediate_cert_request.pki_il5_p1_int.csr
  common_name          = "DoD P1 Intermediate Certificate Authority"
  ttl                  = "43800h"
  exclude_cn_from_sans = true
}
# store signed p1 int ca
resource "vault_pki_secret_backend_intermediate_set_signed" "pki_il5_p1_int" {
  backend = vault_mount.pki_il5_p1_int.path

  certificate = vault_pki_secret_backend_root_sign_intermediate.pki_il5_p1_int.certificate
}

# create role
# See Create/Update Role API documentation for all options
# https://www.vaultproject.io/api-docs/secret/pki#create-update-role
resource "vault_pki_secret_backend_role" "pki_il5_p1_int_leaf" {
  backend            = vault_mount.pki_il5_p1_int.path
  name               = "p1-leaf-cert"
  allowed_domains    = ["dso.mil"]
  allow_subdomains   = true
  allow_bare_domains = false
  allow_glob_domains = false
  enforce_hostnames  = true
  allow_any_name     = false
  allow_ip_sans      = false
  server_flag        = true
  client_flag        = true

  key_usage = [
    "DigitalSignature",
    "KeyAgreement",
    "KeyEncipherment",
  ]

  max_ttl = "2628000" # ~1 month
  ttl     = "2628000"
}

resource "vault_egp_policy" "p1_leaf_validate_common_name" {
  name = "p1-leaf-validate-common-name"
  paths = [
    "pki/il5/p1_int/sign/p1-leaf-cert",
    "pki/il5/p1_int/issue/p1-leaf-cert",
  ]
  enforcement_level = "hard-mandatory"

  policy = file("sentinel/validate-common-name.sentinel")
}