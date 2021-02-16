# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/int_ca?ref=vault"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  mount_path                = "pki/p1_int_ca/int"
  mount_type                = "pki"
  max_mount_ttl             = "94608000" # 3 years
  default_mount_ttl         = "94608000" # 3 years
  intermediate_ca_csr_cn    = "DoD P1 Intermediate CA"
  crl_url                   = ["https://cubbyhole.cnap.dso.mil/v1/pki/p1_int_ca/int/crl"]
  ocsp_svrs                 = ["https://deathstar.cnap.dso.mil"]
  vault_signed_CA           = false #toggle to true once signed cert is received from offline root ca & input below
  vault_signed_cert         = true #will always remain false because vault is not signing the certificate
  csr                       = "vault_pki_secret_backend_intermediate_cert_request.this.csr"

  signed_cert_and_ca_chain  = <<-EOT
-----BEGIN CERTIFICATE-----
MIIGLjCCBBagAwIBAgICEAIwDQYJKoZIhvcNAQENBQAwgaUxCzAJBgNVBAYTAlVT
MREwDwYDVQQIDAhDb2xvcmFkbzEZMBcGA1UEBwwQQ29sb3JhZG8gU3ByaW5nczEZ
MBcGA1UECgwQRG9EIFBsYXRmb3JtIE9uZTENMAsGA1UECwwEQ05BUDEbMBkGA1UE
AwwSYXBhY2hlamVmZi5kc28ubWlsMSEwHwYJKoZIhvcNAQkBFhJwYWNrZXRqZWRp
QGRzby5taWwwHhcNMjEwMjE2MjEyODQ2WhcNMzEwMjE0MjEyODQ2WjBdMQswCQYD
VQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MRMwEQYDVQQLEwpEb0Qg
UDEgUEtJMR8wHQYDVQQDExZEb0QgUDEgSW50ZXJtZWRpYXRlIENBMIICIjANBgkq
hkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAzVrN5QW3w4keoIPaB4kwzsmqtZBalfNc
DaIbKCF0SnYRr8J4+PEzvOmEZX+H1TmWoHegRiCY1lMibZka4ZvWXgmkuxRTbsdG
TdDCUBTr/Xkrz4eHfgHrorZjz1s1Hc43LC6LUWRf0w5Jajam9wtgCWV+IBroo5CE
OE0MFrqcCOhuYmAbP6s/8cioLRW8T+YiWUKRP03P348fqf6B6pRBwT/LHhWgOLKk
/qp1QPsmB1KuGr1laybxbWCHLjVT2vHrXYIhkLnM5+cDuNbe3YWHQ2EZUvp8Cvyi
p37GXvCjskCg5Z48cMFKgSOnlVRV8cDoUWhY7vx1bytpppyG/ycG4fBFjyjH/13y
PzJJSdMemtHP/OF922DngL+xG3f/Gg94iDITapVFhUekmMS2cmC7UZ8R5QYuAsE1
IGpW7it2bIaM0mzck/gJpV57p066qwIxswhnVnlG8SMpL8OSy92LMVWeXZ0sJg21
j63ngF5+CTydvYaJ1SX4qccHYbs0hD/N0+pogBsBIM2nlcVh7wyxETyFMDQaCU7E
pPh9jYUOLTAeqOAXExD9ceUbPeUvmX/J2ACRepc/4z4MU49OA/w3ycn1ZXuzqx4W
4Jks4c/tphDqEyvvVtuP3UTNa18xmBrE7pdUnUvjsUC1OP+XLOEW2pQH1Nu2hGlg
/4HWt2dlN08CAwEAAaOBrjCBqzAdBgNVHQ4EFgQUK3t8L0xa10VGBehDkQJQZObz
ESwwHwYDVR0jBBgwFoAU5o9IHa50FsJbMzbxBgQi8GNAjXcwEgYDVR0TAQH/BAgw
BgEB/wIBAjAOBgNVHQ8BAf8EBAMCAYYwRQYDVR0fBD4wPDA6oDigNoY0aHR0cHM6
Ly9jdWJieWhvbGUuY25hcC5kc28ubWlsOjQ0My92MS9wa2kvY29uZmlnL2NybDAN
BgkqhkiG9w0BAQ0FAAOCAgEArmi/AlxY4Gs6aWYqkinfTG2ljSZeeF1Q+2WobqFV
ljbvlvvwPqZf5E7Hzk1I7ndelpCAXvhOlauLxmJgVaOwOVbdjxlOZqXXz+Z2WvTj
DKzm7DMfRgdS4sTObcpw5YwClzID9h7C7sOqHn10qYxccwGR4bCtLf0vLq1EPCtF
WGBeGwMoQD0pXjhp5u919tq5rCH+q6/wkW+Y0TVO6r4Nkn67x5AXu8+UKB+UC4fk
L6V1rFWr0oCAmm8/fpqsy2ddTMlIGp0gbsZKn/WKtwYAPJk79ovNwOEVuk0VD06P
DU45FXYtxMrtFz3MTB9enR0Bt0w0mJTvGx3/yY1TJ9X1lNBGOCLHwvRkV3mJOUn4
jWOGs+iqaJWfvfoFXg3bGuW4HzJkbViXZsrsv5yhlC3v0y+qT35hMmppGXowPyfE
NCL0UIbvOmU6CIkZQHjTDxNtl4lOq/HdAYGDBGeI05ozN/v4nrpBtQCknwxvPIIK
8K6m5gPGeaEQ5V2/kD8cP1fzbJBZPAEFxP8soLAOpK6Ise29DzV1mjgCu/Z8ijjX
y+PNxy7At2unR1ROqiqF3mAekNizoU0K05ASkztlEbiElwipINp6sfuH9yaWomoH
6nZ4MMHrrBh5SJjz521cs8+CUL6p/gARtWB7PERSeoxB6x/t3dpAYbaInHCYTNKk
sYM=
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
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
Pa1HeW9j
-----END CERTIFICATE-----
EOT
}