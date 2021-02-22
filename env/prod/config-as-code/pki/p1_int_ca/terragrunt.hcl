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
  signed_cert               = false  #toggle to true once signed cert is received from offline root ca & input below
  crl_url                   = ["https://cubbyhole.cnap.dso.mil/v1/pki/p1_int_ca/int/crl"]
  ocsp_svrs                 = ["https://deathstar.cnap.dso.mil"]
  vault_signed_CA           = false #will always remain false because vault is not signing the certificate

  signed_cert_and_ca_chain  = <<-EOT
-----BEGIN CERTIFICATE-----
vault int ca
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
offline rootca
-----END CERTIFICATE-----
EOT
}
