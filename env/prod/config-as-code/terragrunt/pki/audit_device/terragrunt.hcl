# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "/home/sshuser/git-repos/platform-one/terraform-modules/vault/audit"
  // source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/generic_endpoint?ref=vault"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  type        =  "file"
  path        =  "stdout"
  description =  "sends audit logs to stdout to be picked up by fluentbit"
  local       =  false
  options     =  {
    file_path = "stdout"
  }
}