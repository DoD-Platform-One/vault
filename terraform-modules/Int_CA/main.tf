resource "vault_mount" "this" {
  path                      = var.mount_path        #"pki/int/p1_int"
  type                      = var.mount_type        #"pki"
  description               = var.description       #mount for intermediate CA
  default_lease_ttl_seconds = var.default_mount_ttl #94608000 # 3 years
  max_lease_ttl_seconds     = var.max_mount_ttl     #94608000 # 3 years
  seal_wrap                 = var.seal_wrap         #true
  external_entropy_access   = var.external_entropy  #true
  #options                    = (Optional) Specifies mount type specific options that are passed to the backend
}

# generate int ca csr
resource "vault_pki_secret_backend_intermediate_cert_request" "this" {
  backend = var.mount_path

  type        = "internal"
  common_name = var.intermediate_ca_csr_cn
  key_type    = "rsa"
  key_bits    = "4096"

  country      = "US"
  organization = "U.S. Government"
  ou           = "DoD P1 PKI"
}

# sign sub ca csr with p1 int ca
# omitted for main int CA due to offline root CA signing
resource "vault_pki_secret_backend_root_sign_intermediate" "this" {
  count   = var.vault_signed_CA ? 1 : 0
  backend = var.int_mount_path

  csr                  = vault_pki_secret_backend_intermediate_cert_request.this.csr
  common_name          = var.intermediate_ca_csr_cn
  use_csr_values       = true
  max_path_length      = 1
  ttl                  = "43800h"
  exclude_cn_from_sans = true
  country              = "US"
  organization         = "U.S. Government"
  ou                   = "DoD P1 PKI"

  # alt_names - (Optional) List of alternative names
  # ip_sans - (Optional) List of alternative IPs
  # uri_sans - (Optional) List of alternative URIs
  # other_sans - (Optional) List of other SANs
  # ttl - (Optional) Time to live
  # format - (Optional) The format of data
  # private_key_format - (Optional) The private key format
  # key_type - (Optional) The desired key type
  # key_bits - (Optional) The number of bits to use
  # max_path_length - (Optional) The maximum path length to encode in the generated certificate
  # exclude_cn_from_sans - (Optional) Flag to exclude CN from SANs
  # use_csr_values - (Optional) Preserve CSR values
  # permitted_dns_domains - (Optional) List of domains for which certificates are allowed to be issued
  # ou - (Optional) The organization unit
  # organization - (Optional) The organization
  # country - (Optional) The country
  # locality - (Optional) The locality
  # province - (Optional) The province
  # street_address - (Optional) The street address
  # postal_code - (Optional) The postal code
}

# Submits the CA certificate to the PKI Secret Backend.
resource "vault_pki_secret_backend_intermediate_set_signed" "this" {
  count   = var.signed_cert ? 1 : 0
  backend = var.mount_path

  #CA public cert will be "appended" to signed cert on line 16 below
  certificate = var.signed_cert_and_ca_chain != "" ? var.signed_cert_and_ca_chain : "${vault_pki_secret_backend_root_sign_intermediate.this[0].certificate}\n${var.ca_chain}"
}

resource "vault_pki_secret_backend_config_urls" "this" {
  count   = var.signed_cert ? 1 : 0
  backend = var.mount_path

  crl_distribution_points = var.crl_url
  ocsp_servers            = var.ocsp_svrs
}

resource "vault_pki_secret_backend_crl_config" "this" {
  count   = var.signed_cert ? 1 : 0
  backend = var.mount_path

  expiry  = var.expiry
  disable = var.disable_crl
}
