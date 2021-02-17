# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/policy?ref=vault"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  name   = "change-userpass-password"
  policy = <<EOT
# -----------------------------------------------------------------------------
# Allow users to change their own userpass password
# -----------------------------------------------------------------------------
path "auth/userpass/users/{{ identity.entity.aliases.${userpass_mount_accessor}.name }}/password" {
  capabilities = [ "update" ]

  allowed_parameters = {
    "password" = []
  }
}

EOT
}
