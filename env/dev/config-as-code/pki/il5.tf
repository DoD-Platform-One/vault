## Is this even needed? Appears to be duplicate of int in root.tf

# # mount point for il5 p1 intermediate ca
# resource "vault_mount" "il5_p1_pki_int" {
#   path                  = "il5_p1_pki_int"
#   type                  = "pki"
#   max_lease_ttl_seconds = 94608000 # 3 years
#   seal_wrap                = true
#   external_entropy_access  = true
# }
# # generate p1 il5 csr
# resource "vault_pki_secret_backend_intermediate_cert_request" "il5_p1_pki_int" {
#   backend = vault_mount.il5_p1_pki_int.path

#   type        = "internal"
#   common_name = "DoD P1 IL5 Intermediate Certificate Authority"
#   key_type    = "rsa"
#   key_bits    = "4096"
# }
# # sign il5 csr with p1 int ca
# resource "vault_pki_secret_backend_root_sign_intermediate" "il5_p1_pki_int" {
#   backend = vault_mount.pki_il5_p1_int.path

#   csr                  = vault_pki_secret_backend_intermediate_cert_request.il5_p1_pki_int.csr
#   common_name          = "DoD P1 IL5 Intermediate Certificate Authority"
#   ttl                  = "43800h"
#   exclude_cn_from_sans = true
# }
# # store signed il5 p1 int ca
# resource "vault_pki_secret_backend_intermediate_set_signed" "il5_p1_pki_int" {
#   backend = vault_mount.il5_p1_pki_int.path

#   certificate = vault_pki_secret_backend_root_sign_intermediate.il5_p1_pki_int.certificate
# }
# # create role
# resource "vault_pki_secret_backend_role" "il5_p1_pki_int_leaf" {
#   backend            = vault_mount.il5_p1_pki_int.path
#   name               = "il5-p1-leaf-cert" # name of role
#   allowed_domains    = ["il5.dso.mil"] 
#   allow_bare_domains = false          #
#   allow_subdomains   = true           #
#   allow_glob_domains = false          #
#   allow_any_name     = false          # adjust allow_*, flags accordingly
#   allow_ip_sans      = false          #
#   server_flag        = true           #
#   client_flag        = true           #
#   key_usage          = [
#       "DigitalSignature",
#       "KeyAgreement",
#       "KeyEncipherment",
#   ]
#   max_ttl            = "2628000"         # ~1 month
#   ttl                = "2628000"
# }
