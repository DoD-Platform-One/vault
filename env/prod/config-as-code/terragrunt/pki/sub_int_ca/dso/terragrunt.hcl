# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "/Users/gabe/Workspace/terraform-modules/vault/sub_ca"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency mount {
  config_path = "../../p1_int/mount"
  mock_outputs = {
    path = "abc-123"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  mount_path        = "pki/tf-test/int/dso_int"
  sub_ca_csr_cn     = "DoD P1 DSO Intermediate CA"
  int_mount_path    = dependency.mount.outputs.path
  leafcert          = "dso-p1-leaf-cert"
  allowed_domains   = ["dso.mil"]
}