# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  # Gabe
  #source = "/Users/gabe/Workspace/terraform-modules/vault/mount"
  source = "/Users/cameron.banowsky/infrastructure/dev/repo1/cnap/terraform-modules/vault/mount"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  mount_path        = "pki/il2/int"
  mount_type        = "pki"
  max_mount_ttl     = "94608000" # 3 years
  default_mount_ttl = "94608000" # 3 years
  seal_wrap         = true
  external_entropy  = true
}