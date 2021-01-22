#CA public cert will be "appended" to signed cert on line 16 below

# store signed p1 int ca
resource "vault_pki_secret_backend_intermediate_set_signed" "pki_p1_int" {
  backend = vault_mount.pki_p1_int.path

  certificate = <<-EOT
  -----Begin Certificate-----
  p1 int cert
  -----End Certificate-----
  -----Begin Certificate-----
  p1 rootca cert
  -----End Certificate-----
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

  max_ttl = "94608000" # 3 years
  ttl     = "94608000" # 3 years
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