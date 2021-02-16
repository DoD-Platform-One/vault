# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/pki_secret_backend_intermediate_cert_request?ref=vault"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency mount {
  config_path = "../_mount"
  mock_outputs = {
    path = "abc-123"
  }
}


# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  mount_path        = dependency.mount.outputs.path
  intermediate_ca_csr_cn  = "DoD P1 IL2 Intermediate CA"
}
