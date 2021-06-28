# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../terraform-modules/cert_issuing_ca"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency int_ca_mount {
  config_path = "../il2_int_ca"
  mock_outputs = {
    path = "abc-123"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  mount_path                = "pki/<your-cert-issuing-ca-mount-point>"
  mount_type                = "pki"
  max_mount_ttl             = "94608000" # length of cert issuing CA is 3 years
  default_mount_ttl         = "94608000" # length of cert issuing CA is 3 years
  ca_csr_cn                 = "DoD P1 IL2 Pipeline CA"
  int_mount_path            = dependency.int_ca_mount.outputs.path
  crl_url                   = ["https://cubbyhole.cnap.dso.mil/v1/pki/<your-cert-issuing-ca-mount-point>/crl"]
  ocsp_svrs                 = ["https://deathstar.cnap.dso.mil"]
  name                      = "il2-pipeline-leaf"
  allowed_domains           = ["pipeline.il2.dso.mil"]
  allow_subdomains          = false
  max_ttl                   = 7200 #two hours max certifcate ttl
  ttl                       = 3600 #one hour certificate ttl
  key_usage                 = ["DigitalSignature", "KeyAgreement", "KeyEncipherment"]
}
