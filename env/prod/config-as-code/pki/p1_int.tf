# mount point for p1 intermediate ca
resource "vault_mount" "pki_p1_int" {
  path                    = "pki/int/p1_int"
  type                    = "pki"
  max_lease_ttl_seconds   = 94608000 # 3 years
  default_lease_ttl_seconds = 94608000 # 3 years
  seal_wrap               = true
  external_entropy_access  = true
}

# generate p1 int ca csr
resource "vault_pki_secret_backend_intermediate_cert_request" "pki_p1_int" {
  backend = vault_mount.pki_p1_int.path

  type        = "exported"
  common_name = "DoD P1 Intermediate CA 1"
  key_type    = "rsa"
  key_bits    = "4096"

  country      = "US"
  organization = "U.S. Government"
  ou           = "DoD PKI"
}

# review README before applying terraform
# store signed p1 int ca
resource "vault_pki_secret_backend_intermediate_set_signed" "pki_p1_int" {
  backend = vault_mount.pki_p1_int.path

#CA public cert will be "appended" to signed cert on line 16 below

  certificate = <<-EOT
-----BEGIN CERTIFICATE-----
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
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
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
47k8zokwyEcnX+bxhFMm
-----END CERTIFICATE-----
EOT
}

# create role
# See Create/Update Role API documentation for all options
# https://www.vaultproject.io/api-docs/secret/pki#create-update-role
resource "vault_pki_secret_backend_role" "pki_p1_int_leaf" {
  backend            = vault_mount.pki_p1_int.path
  name               = "p1-leaf-cert"
  #allowed_domains    = ["dso.mil"]
  allow_subdomains   = true
  allow_bare_domains = true
  #allow_glob_domains = false
  enforce_hostnames  = false
  allow_any_name     = true
  allow_ip_sans      = false
  server_flag        = false
  client_flag        = false
  require_cn         = false
  key_usage = [
    "DigitalSignature",
    "CertificateSign",
    "CRL Sign",
  ]

  max_ttl = "94608000" # 3 years
  ttl     = "94608000" # 3 years
}
