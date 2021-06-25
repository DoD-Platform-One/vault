# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/identity_group"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency user1_identity_id {
  config_path = "../../users/vault_user1"
  mock_outputs = {
    member_entity_ids = "abc-123"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  name                = "sudo"
  policies            = ["sudo"]
  member_entity_ids   = [
    dependency.user1_identity_id.outputs.id,
  ]
}
