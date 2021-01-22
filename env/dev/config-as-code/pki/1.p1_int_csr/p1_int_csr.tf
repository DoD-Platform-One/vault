# mount point for p1 intermediate ca
resource "vault_mount" "pki_p1_int" {
  path                    = "pki/int/p1_int"
  type                    = "pki"
  max_lease_ttl_seconds   = 94608000 # 3 years
  seal_wrap               = var.enable_seal_wrap
#test if external entropy works with AWS KMS
  external_entropy_access  = true
}

# generate p1 int ca csr
resource "vault_pki_secret_backend_intermediate_cert_request" "pki_p1_int" {
  backend = vault_mount.pki_p1_int.path

  type        = "internal"
  common_name = "DoD P1 Intermediate Certificate Authority"
  key_type    = "rsa"
  key_bits    = "4096"

  country      = "US"
  province     = "Colorado"
  locality     = "Colorado Springs"
  organization = "Department of Defense"
}