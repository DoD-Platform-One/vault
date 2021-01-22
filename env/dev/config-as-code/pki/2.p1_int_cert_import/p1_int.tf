# mount point for p1 intermediate ca
resource "vault_mount" "pki_p1_int" {
  path                    = "pki/int/p1_int"
  type                    = "pki"
  max_lease_ttl_seconds   = 94608000 # 3 years
  seal_wrap               = var.enable_seal_wrap
  external_entropy_access  = true
}

#CA public cert will be appended to signed cert on line 16 below

# store signed p1 int ca
resource "vault_pki_secret_backend_intermediate_set_signed" "pki_p1_int" {
  backend = vault_mount.pki_p1_int.path

  certificate = <<EOT
  "-----Begin Certificate-----
  asdfasdfasdf
  -----End Certificate-----"
EOT
}

# create role
# See Create/Update Role API documentation for all options
# https://www.vaultproject.io/api-docs/secret/pki#create-update-role
resource "vault_pki_secret_backend_role" "pki_p1_int_leaf" {
  backend            = vault_mount.pki_p1_int.path
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
    "pki/int/p1_int/sign/p1-leaf-cert",
    "pki/int/p1_int/issue/p1-leaf-cert",
  ]
  enforcement_level = "hard-mandatory"

  policy = file("sentinel/validate-common-name.sentinel")
}