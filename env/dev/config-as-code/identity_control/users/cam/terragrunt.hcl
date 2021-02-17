# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/user?ref=vault"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  type                      = "userpass"
  max_lease_ttl             = "60m"
  default_lease_ttl         = "30m"
  identity_entity_name      = "cameron.banowsky"
  #identity_entity_policies  = ["change-userpass-password"]
  userpass_username         = "cam"
}