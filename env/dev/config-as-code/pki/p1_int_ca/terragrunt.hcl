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
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
Unk=
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
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
Pa1HeW9j
-----END CERTIFICATE-----
EOT
}
