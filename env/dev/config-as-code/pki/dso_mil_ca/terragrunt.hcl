# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/cert_issuing_ca?ref=vault"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency p1_int_mount {
  config_path = "../p1_int_ca"
  mock_outputs = {
    path = "abc-123"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  mount_path                = "pki/dso/int"
  mount_type                = "pki"
  max_mount_ttl             = "94608000" # 3 years
  default_mount_ttl         = "94608000" # 3 years
  sub_ca_csr_cn             = "DoD P1 DSO CA"
  int_mount_path            = dependency.p1_int_mount.outputs.path
  csr                       = "vault_pki_secret_backend_intermediate_cert_request.this.csr"
  signed_cert_and_ca_chain  = "vault_pki_secret_backend_root_sign_intermediate.this.certificate"
  crl_url           = ["https://cubbyhole.cnap.dso.mil/v1/pki/dso/int/crl"]
  ocsp_svrs         = ["https://deathstar.cnap.dso.mil"]
  name = "dso-leaf"
  allowed_domains = ["dso.mil"]
  allow_subdomains = false
  max_ttl = 31556926 #annual lease
  ttl = 31556926 #annual lease
  key_usage = ["DigitalSignature", "KeyAgreement", "KeyEncipherment"]
}

