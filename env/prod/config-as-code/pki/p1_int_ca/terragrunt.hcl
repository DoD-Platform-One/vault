# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/int_ca"
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
  signed_cert               = true  #toggle to true once signed cert is received from offline root ca & input below
  crl_url                   = ["https://cubbyhole.cnap.dso.mil/v1/pki/p1_int_ca/int/crl"]
  ocsp_svrs                 = ["https://deathstar.cnap.dso.mil"]
  vault_signed_CA           = false #will always remain false because vault is not signing the certificate

  signed_cert_and_ca_chain  = <<-EOT
-----BEGIN CERTIFICATE-----
MIIGFDCCA/ygAwIBAgICEAAwDQYJKoZIhvcNAQENBQAwgYgxCzAJBgNVBAYTAlVT
MREwDwYDVQQIDAhDb2xvcmFkbzEZMBcGA1UEBwwQQ29sb3JhZG8gU3ByaW5nczEZ
MBcGA1UECgwQRG9EIFBsYXRmb3JtIE9uZTENMAsGA1UECwwEQ05BUDEhMB8GCSqG
SIb3DQEJARYScGFja2V0amVkaUBkc28ubWlsMB4XDTIxMDMwNDA2MTA0OFoXDTMx
MDMwMjA2MTA0OFowXTELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4gR292ZXJu
bWVudDETMBEGA1UECxMKRG9EIFAxIFBLSTEfMB0GA1UEAxMWRG9EIFAxIEludGVy
bWVkaWF0ZSBDQTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMxeuPk/
Dp9xDNQEJrGj7nrqx8kFyUyWeQKHuYyCF6Si4CCOQhIxoz+0F91n1fGZ5mZOejTl
s+CYbcrb5tMjhb8rCxGRQGAcZlXf9zCnjUP1DyigZ09PD01r0sehEAU6Yx9bmN3F
vKuMw/I26E2UCo+9LchjUPe4URqkbycuxVc5uvbxRqfZgjMnwK63ynzVE/aw/31H
62jkiam+QZVlXcjlnoOWCuARO9badHXXauaMNsBRtNVpvgT8fGBEvj7FDZQ69Xt0
9wNKj72qZMiwdghxjryu2Bd1qah7WMCn4NikDcp2Tr2ZkQSNtg9N0sbCxBUq3N7n
I9jFhgQuQmPyczZqhLBNkgRITcMohdEwUB+/4vtW1hVxAl9pEixhCo9CJtR7vShV
wlDcTsNxn0IMkuDivQPN8Vjo6qcYCNgRU60PMHdDb6e6xWMUdf9yQDZRAYUaruKN
fK3uHb5M8k4ZMjtJsp+rAEsJVmPYl/nujV83eCdRdwDNRxzN25eOKG+IcyGMJGzH
13xgFgG3qywltbZ2b4pqeLDX294+yHQC0z5aS3zT2+L2Jq0maJbqvJdHZneTHL/p
49k6mH2VNFL/CzCL4KE129SqdUIMJ9EbQgdxT6tpMixMy2IiVii0RlYc+XG8fLRM
HLsZT1GFG1u7Q8I568K3CzacGW07bjGvt2IFAgMBAAGjgbEwga4wHQYDVR0OBBYE
FIQZnkAz1Ni42Ur3dDbGvRaZ2AduMB8GA1UdIwQYMBaAFISQ6mhle7fuRKEpK9HZ
HQxpuw8ZMBIGA1UdEwEB/wQIMAYBAf8CAQIwDgYDVR0PAQH/BAQDAgGGMEgGA1Ud
HwRBMD8wPaA7oDmGN2h0dHBzOi8vY3ViYnlob2xlLmNuYXAuZHNvLm1pbC92MS9w
a2kvcDFfaW50X2NhL2ludC9jcmwwDQYJKoZIhvcNAQENBQADggIBAG7Ei3jWvrRw
fyC0aeKWGi8hS41xQ/hnqozWy7PRi5tnVoeLAtQ169smjK52NxzkWclDkGfcGuUT
kPto4RQ9SKLUYrjFWwWZGn5L3mhDxiQndAFCZROLPWz1QuSKle4D1Jh50PFKw/ii
ewvrBwbR4VM0jkZr6KOtK/XE1woUB9NGb61FZvP9aVmsDX283orLc6omqqO5cx+O
Ex2ZmonKh1fGSxfa173Xl7wJZlsp6aynS2Vun5ychjIGijS+WFstgYxr7lauAboB
ivo3ogmqe0/bR/TQHqUR5Itn0kW3yz3Au/UVB2zA8/RBewH0P9Pp77WNDhYPGD4r
feKuj9whmI4QGFQEzFKRq+vKbkiNV7qq02/Bs0S3mvIXliDvtQSd11vQeKa4Qg+O
pRE1vjrlJfMAjtyy7fsOSyhTvkasekD7DdDzAQH5Le+x+/rqbqzfWR8OyQKDT3hD
Nr1Iqcv3UrsgDLjN7OvSRl8/v8uG5dNKdPi9kplvP2e1ureFBznZdUYooyMlZlnj
uoC3KnaeZEODnkPB06BRyb1um59VKtyu4kry9XFJDO3O0anB0ejw83rWmR1s7lwx
yHiME3PTNnn8y11VwqF8IZTcDzs91jrbiaoB2POsAOSX3BlHv1ZQxGIjrR9Lirur
cj/6Grsdet0MVdDwHoMUHhybflA+8F/a
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
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
-----END CERTIFICATE-----
EOT
}
