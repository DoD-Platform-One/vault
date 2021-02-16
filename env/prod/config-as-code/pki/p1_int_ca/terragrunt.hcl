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
  crl_url                   = ["https://cubbyhole.cnap.dso.mil/v1/${vault_mount.this.path}/crl"]
  ocsp_svrs                 = ["https://deathstar.cnap.dso.mil"]
  vault_signed_CA           = false #toggle to true once signed cert is received from offline root ca & input below
  vault_signed_cert         = false #will always remain false because vault is not signing the certificate
  signed_cert_and_ca_chain  = <<-EOT
-----BEGIN CERTIFICATE-----
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
Ig==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
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
47k8zokwyEcnX+bxhFMm
-----END CERTIFICATE-----
EOT
}




} 

