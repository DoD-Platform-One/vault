# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/user"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency userpass_auth_backend {
  config_path = "../../userpass_auth_backend"
  mock_outputs = {
    path = "abc-123"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  auth_backend              = dependency.userpass_auth_backend.outputs.accessor
  identity_entity_name      = "israel.morales"
  identity_entity_policies  = ["change-userpass-password"]
  userpass_username         = "imorales"
}
