# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  # Gabe dev
  #source = "/Users/gabe/Workspace/terraform-modules/vault/intermediate_ca_csr"
   source = "/Users/cameron.banowsky/infrastructure/dev/repo1/cnap/terraform-modules/vault/pki_secret_backend_intermediate_cert_request"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency mount {
  config_path = "../mount"
  mock_outputs = {
    path = "abc-123"
  }
}


# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  mount_path        = dependency.mount.outputs.path
  intermediate_ca_csr_cn  = "DoD P1 DSO Intermediate CA"
}

# # create role
# # See Create/Update Role API documentation for all options
# # https://www.vaultproject.io/api-docs/secret/pki#create-update-role
# resource "vault_pki_secret_backend_role" "pki_p1_int_leaf" {
#   backend            = vault_mount.pki_p1_int.path
#   name               = "p1-leaf-cert"
#   #allowed_domains    = ["dso.mil"]
#   allow_subdomains   = true
#   allow_bare_domains = true
#   #allow_glob_domains = false
#   enforce_hostnames  = false
#   allow_any_name     = true
#   allow_ip_sans      = false
#   server_flag        = false
#   client_flag        = false
#   require_cn         = false
#   key_usage = [
#     "DigitalSignature",
#     "CertificateSign",
#     "CRL Sign",
#   ]

#   max_ttl = "94608000" # 3 years
#   ttl     = "94608000" # 3 years
# }
