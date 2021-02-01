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

  type        = "internal"
  common_name = "DoD P1 Intermediate CA"
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
MIIGLDCCBBSgAwIBAgICEAQwDQYJKoZIhvcNAQENBQAwgaQxCzAJBgNVBAYTAlVT
MREwDwYDVQQIDAhDb2xvcmFkbzEZMBcGA1UEBwwQQ29sb3JhZG8gU3ByaW5nczEZ
MBcGA1UECgwQRG9EIFBsYXRmb3JtIE9uZTENMAsGA1UECwwEQ05BUDEaMBgGA1UE
AwwRcDEtcm9vdGNhLmRzby5taWwxITAfBgkqhkiG9w0BCQEWEnBhY2tldGplZGlA
ZHNvLm1pbDAeFw0yMTAyMDExNjM2MzRaFw0zMTAxMzAxNjM2MzRaMFwxCzAJBgNV
BAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxEDAOBgNVBAsTB0RvRCBQ
S0kxITAfBgNVBAMTGERvRCBQMSBJbnRlcm1lZGlhdGUgQ0EgMTCCAiIwDQYJKoZI
hvcNAQEBBQADggIPADCCAgoCggIBAMUEnW2EpB0Oi7L/zcLsecp/QKOspuXZJCT7
0acCAlX9Im88p9+VE75lUkPR+CAz9/SxcMSDYFxrj+D98FO8l1hAt4Jg8PL1fXZx
XrGPysJYCGHwX100TfVH5HEBMsuae/kfd13VzG2no6FjqfXmxZzR/Oje3H/aLfTd
8wGykReGlsxp47zx1zymhhCMLyjevwioKVYoaABBULUp3G/BZaEgjiY1H4FxpbAv
Tp0Ih/aKmry1ZUe6c9nQvHmRg5+CAlvbMWaA0UQ+hGN+yYeq7AoAQ2U1siskdqr4
m0NEUK0VV4qrZ/STmXR2hdib4DgOysx1mACLL2lgsRrjqC3WNE7dYnbzniNnkxf3
CNJiVMn8E+DTVPVQ68IOqvENist3TvDdnIQbjP76i0xdQoq7c5Cp2Fl97HpI7oyM
W+hK1L9fdHZLjD9SokgymUtkNxB6sobucSWr9azwEAPj8toKd7FpGDrI7MuqcQ+I
N0KzFSYJ1y1iV720cGlpAZfCDRs07wTq+hUC/0LJe4vHhdKe7srdqiA5XQ/zvJ4m
OqOws2+vhxso/kQjRukUgEVOTlqy2uOo9MDOoIggyZHb2KWT3v404ul4Jw6q7Vxm
aFD50hRY/2fBV4UuVbXx5N4sBJxOGoJ4PytXAwZIHG3qzsgLl0dUPf8I9OocZsWa
q5rzPERNAgMBAAGjga4wgaswHQYDVR0OBBYEFG7pKgGMUThZCO/tYKLj36OpxQ+N
MB8GA1UdIwQYMBaAFG/uw5DOnA5wZMwFPIza/6Wz9nHTMBIGA1UdEwEB/wQIMAYB
Af8CAQEwDgYDVR0PAQH/BAQDAgGGMEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHBzOi8v
Y3ViYnlob2xlLmNuYXAuZHNvLm1pbDo0NDMvdjEvcGtpL2NvbmZpZy9jcmwwDQYJ
KoZIhvcNAQENBQADggIBAA8xpg4Gjme1rzexvFjYjIuY+FJDAcr/PcqmQURnOIvS
5BvCS96aDeyzfSL4cERPR/WgMURC7y04hn/fheo6v1Y4z87TZzZgNPPc+i3y3jAK
vuhh8WxekiwCF+pq+cabEQ/n2y5xIZyD1bhaqgv7oR9Ykm8syGsFng+YPgz6FN1N
hcQFVKEC8LWpEfndiFtNfQShTJdb8+IUOA00cMgwjD6H0GBUkVjOls53E5HnsOuV
lDO4pnVeNkuuoQmoXmmeVnL0/YBxEzyKCe9nEmxBwivHYk/NNQ88RpRaNsV+x8os
bHZsCkRPOusLGbrlhfxacktegEwr1xQpE0xkZ1dVOW9yW0KWgXuoJXIPXwCJR/qT
w2Pa+w51yKCft9zgqR0g9QRxG3e/NAHMsWvN4kSBbYxzrLpNP7zB27AANLaZXe/l
gdDfLU/cABDCPHUMgSbF7bJuIyHrJ8HevYlkdnCinwOW5CgmbcD7AuLgNWQCLdA8
yzRu1zZ09Bw5jwBI0Fpm2seGKPaLNk9lFT4w5D4J825mxJ6Ppi0YkR2FnytrKsUh
2qO9iyWngZJQ5P64mLougHI7V45APeSCfmxBLqFhvuBkE0NBpcmoVX1CWOcKJNTb
Vo0xt8GXblE01ZqRitCxc4IGyj2o3psMj17eps/6eYaUNZ0CY9z4IyxTDzm5MJ7v
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
