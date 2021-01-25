
# store signed p1 int ca

module "p1_int" {
  source = ../
}

resource "vault_pki_secret_backend_intermediate_set_signed" "pki_p1_int" {
  backend = "${module.p1_int.pki_p1_int_vault_mount}"

#CA public cert will be "appended" to signed cert on line 16 below

  certificate = <<-EOT
-----BEGIN CERTIFICATE-----
MIIGRDCCBCygAwIBAgICEAEwDQYJKoZIhvcNAQENBQAwgakxCzAJBgNVBAYTAlVT
MREwDwYDVQQIDAhDb2xvcmFkbzEZMBcGA1UEBwwQQ29sb3JhZG8gU3ByaW5nczEZ
MBcGA1UECgwQRG9EIFBsYXRmb3JtIE9uZTENMAsGA1UECwwEQ05BUDEfMB0GA1UE
AwwWY3ViYnlob2xlLmNuYXAuZHNvLm1pbDEhMB8GCSqGSIb3DQEJARYScGFja2V0
amVkaUBkc28ubWlsMB4XDTIxMDEyMjIzMjk0NFoXDTMxMDEyMDIzMjk0NFowbzEL
MAkGA1UEBhMCVVMxETAPBgNVBAgTCENvbG9yYWRvMRkwFwYDVQQKExBEb0QgUGxh
dGZvcm0gT25lMTIwMAYDVQQDEylEb0QgUDEgSW50ZXJtZWRpYXRlIENlcnRpZmlj
YXRlIEF1dGhvcml0eTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANcm
xECbYFWCP97OlO7OjzmuvbZUwVmwVLVNxe0HURNLDlCdmso3dIdDW8u2sFrphjD4
cF4NYF5fmwvig25MR1fIBAt46CgFQ5fEyVhXVKN2JORODu1o712JX4FB4W1+cC57
YFXf6NhXZB0YEUgn0uCIFFI+BZHH20s8vAYBAwgKmT94M7IbyS4hreu9GIEnzjIf
LKj7VGylpHjmtLdTybsTDeTDnmDJBlEdV1LQtZqQb69eagD1xcb0d1dA/9t2X32d
cJhBlNrFLDkLOVE6tuJY7mE3Zfm4RWJKmixw5JRITabLoPCrRnnWMcER3yFggAG0
YdVgxjC4MQkEnP5w6Z76M+tb7PFpa2+4ixRCPEDlxRInqseDwsFfqwrGHwjpYY8i
qj4zmV4jmCu+QIxHmrIkYrePppMTx3Vvv4kDBRhvl12gXb43pg4P4GCvTPkxVhyN
lIt/7SuX1082hRA3xO/rrMrG0dnUg7XG3Y3k2pbP17Tc3Rnj5OQP9LAQYgYt+mgk
N0itS8T0eHmFuWJVFqEwpTqcru7M1eKsiVPHfY9NFZuC72O+48HX9O7I62+bsF5C
dNs2/Z3NMsz5ZEvQxXIZ8h+gydSV4Rc08FrZ+Zk9ZjOPLkDOzSC9TXVuXZhgIYfC
APDAovz90tZYppK4ExD6o1qS/xk3W3jIbI/SUdYbAgMBAAGjga4wgaswHQYDVR0O
BBYEFBGeTI8n9GtmYa2Ofc1bv63iYk7sMB8GA1UdIwQYMBaAFNEBhfJf92F0bT8l
Y8ChEQsATfZEMBIGA1UdEwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgGGMEUG
A1UdHwQ+MDwwOqA4oDaGNGh0dHBzOi8vY3ViYnlob2xlLmNuYXAuZHNvLm1pbDo0
NDMvdjEvcGtpL2NvbmZpZy9jcmwwDQYJKoZIhvcNAQENBQADggIBABuHBu9CTnzY
IRRg8QC7pgiRcVYZarR43OaaT3t48xau9cg2rBd+LGXaidvJIrD6fWF27VBRmni4
thKhEuxR9i3cX7nCBkFo1mFRO7zcMK5qXH70PkYMYs7DX2EbTd/9YSQeXfD9AGF/
pgWpez0ILRmfOt1dQsk3nX37CcAwb5fj2aLc+qlgnkLynhoxnXXvWYQ9xGTi3DeT
vjmFglr+0DKtL0XWjhnNGVl0gaym0NhYkHgWBwL2/9M6WPoWI3bPC+176mUvxTgi
/XZOakeIWU5xyDJBt94WjGjxZ8hqRrum/q8+jhVUOTtEeNenXzpMm2KTmU0KZN0K
BhT1h8YZusNs4Rn5lKQoTK7JgnyYazHjbdoSEaoRiZUA8J8+KKvmiA/4J4m4FQuX
HTqw03ZZO/3uR1FDcvyK77z6e25faMIDagiQQ8VT3tE0o8HUTAhHoRafBqqyozyN
38DRWHiN4/RIq+06QErAn2E4PjRBXQAJYHAdoT60y2Y4rF4jOXsjYKw0MA/8cYvA
jypiOy57Gmadep8yFBAqcOyjtBNhbFcG8L4ifWowSMnqvg/FeGHvYMrWb83QDaNH
8VH+MwJ+XrWhq2FWfPMeE7xBZqBATDi/XKsqRJ5GE5+jZmfv0cF4SqsJy//3/c81
1amMYaHRWGVp4YyZrCVmlQHRRD/9yuCC
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIGRTCCBC2gAwIBAgIUV/wDrp9wZ5O53hYsy2doxVh7ec4wDQYJKoZIhvcNAQEN
BQAwgakxCzAJBgNVBAYTAlVTMREwDwYDVQQIDAhDb2xvcmFkbzEZMBcGA1UEBwwQ
Q29sb3JhZG8gU3ByaW5nczEZMBcGA1UECgwQRG9EIFBsYXRmb3JtIE9uZTENMAsG
A1UECwwEQ05BUDEfMB0GA1UEAwwWY3ViYnlob2xlLmNuYXAuZHNvLm1pbDEhMB8G
CSqGSIb3DQEJARYScGFja2V0amVkaUBkc28ubWlsMB4XDTIxMDEyMTE5MTg0MVoX
DTMxMDExOTE5MTg0MVowgakxCzAJBgNVBAYTAlVTMREwDwYDVQQIDAhDb2xvcmFk
bzEZMBcGA1UEBwwQQ29sb3JhZG8gU3ByaW5nczEZMBcGA1UECgwQRG9EIFBsYXRm
b3JtIE9uZTENMAsGA1UECwwEQ05BUDEfMB0GA1UEAwwWY3ViYnlob2xlLmNuYXAu
ZHNvLm1pbDEhMB8GCSqGSIb3DQEJARYScGFja2V0amVkaUBkc28ubWlsMIICIjAN
BgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAuSuVndFwxT0kx4Gy7HgE1dRIUk1F
lobN/7xOTzbc3arbZrFNfvDj1NMi4B44Mg1sE3TKVd2HRAhHbkcvGIbVX0F5tHjo
kigNCR/K2iGKpv+ElojveQyKpN2Fv4nrhFRhHaFTGM5e89Q+pca/CayQMMlrhRfo
6OR2fgEvofMsUO6+h6W9uPAy6ONybRtu6md35bA5eL8CLNgtVoBDqS7ujD16dh2o
51dPMiFR65S1aKHv2S8GwzHcgP3nZLULuMpr/cYoRHuwNTJ4slpHwQMXDlzPt8/I
LDEw4qWIuyR5UCDW+BFCsvYdcZnVxKIvEsQ/odM5WxMFklukZ7D79CbD2ShNRhzK
+eDPWIAG36E6ubADKc8pLy0Bnk0v4PPPl853XVEvH9MjRwdD+YzKdvIYY7tt88aS
goDNbiY3mt8BsmyjHwiZa4dx5OMClCX7gqx3jQA7ECtJoaoxbNOmV879RoDM6ZkS
frtNVNdiSW+eeqEP0TxS3sVOJNyiR/ZrdQ7aDBiHp4iMkAcIHjgP2UO0YCFdF9gx
TkDLJChpuWLLY8lGrT5I846pQK+LTpEsumPRJBy9M+L/9yQ0laOqs/GAZ3RwtZ8a
jlGw93/zEEhoIHVSwa3IncizIBjSMtwIZz9iBKimZB5Xcfn0ZfysY76px5z0kyk+
PeriksMFzIKUsFECAwEAAaNjMGEwHQYDVR0OBBYEFNEBhfJf92F0bT8lY8ChEQsA
TfZEMB8GA1UdIwQYMBaAFNEBhfJf92F0bT8lY8ChEQsATfZEMA8GA1UdEwEB/wQF
MAMBAf8wDgYDVR0PAQH/BAQDAgGGMA0GCSqGSIb3DQEBDQUAA4ICAQB5EXK0UjqR
iUSU76W0BG79uzH2klwfjH06nqboLF57/nlODRO1PKWUppBD3Kdh11bFomeYPjJ+
s/racno7s++KgI3l/mxNjngbSFWaGT76cb6WxyZE0etcHsnB6snIbwZQGzbFRU9O
dyCJOwLMsEM8R6JxMk0PeHAllOi2kkSgUTZYG/Mw1dBSRG6TWWIOj+7IqVWy8zhn
I0hBf0xnZrzinEgNMcKLuwjVxInX3iSYp8mYyYgf4tVeSk20dofgeT4it92b96/s
Lk8DnotJh2245ZEm1qiW9fMbaaMVbXpOZsPfSNyj7/wLcQo2vLDV4rmRLE2oGSpF
OjTIey/M4qHd8MLp+ndGNUBYtvxmdtFzFvrxx2+mbH2cU8x65vSmoQrgQJ+h0aEe
vWGoLL6Q2FaJbx8MQFd8U572aOXdWRyVtFNgYrsBXkYU/DUdss4+OE98Oiot+Zt1
6NNnx5UF+eTCY3cu82UYRIvDbxgX8RdlinkbKc5ZUJsPu4jor/DKpB7pamLMKwpQ
JbfrIyrfpG0K85Udn2ZUwvjmAtVV8e/GWNihKF0qtcy8rVh+H2j9B/cLPTAJju2z
AS3GdfNShkyo48ZDhiSJNuGpSlPbcQLSogMofYHq4jprsxE6H830EHa0WtKNdnk+
EbtZJJscxN/YdhePiBgchk8MCLZBz3ZhSg==
-----END CERTIFICATE-----
EOT
}

# create role
# See Create/Update Role API documentation for all options
# https://www.vaultproject.io/api-docs/secret/pki#create-update-role
resource "vault_pki_secret_backend_role" "pki_p1_int_leaf" {
  backend            = "${module.p1_int.pki_p1_int_vault_mount}"
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

  policy = file("../sentinel/validate-common-name.sentinel")
}