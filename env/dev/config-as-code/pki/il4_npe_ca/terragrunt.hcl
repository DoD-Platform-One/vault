# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/cert_issuing_ca"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency int_ca_mount {
  config_path = "../il4_int_ca"
  mock_outputs = {
    path = "abc-123"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  mount_path                = "pki/il4/npe"
  mount_type                = "pki"
  max_mount_ttl             = "94608000" # 3 years
  default_mount_ttl         = "94608000" # 3 years
  ca_csr_cn                 = "DoD P1 IL4 NPE CA"
  int_mount_path            = dependency.int_ca_mount.outputs.path
  crl_url                   = ["https://cubbyhole.cnap.dso.mil/v1/pki/il4/npe/crl"]
  ocsp_svrs                 = ["https://deathstar.cnap.dso.mil"]
  name                      = "il4-npe-leaf"
  allowed_domains           = ["npe.il4.dso.mil"]
  allow_subdomains          = false
  max_ttl                   = 31556926 #annual lease
  ttl                       = 31556926 #annual lease
  key_usage                 = ["DigitalSignature", "KeyAgreement", "KeyEncipherment"]
}
