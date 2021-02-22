# # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# # working directory, into a temporary folder, and execute your Terraform commands in that folder.
# terraform {
#   source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/identity_group?ref=vault"
# }

# # Include all settings from the root terragrunt.hcl file
# include {
#   path = find_in_parent_folders()
# }

# dependency cam_identity_id {
#   config_path = "../../users/cam"
#   mock_outputs = {
#     id = "abc-123"
#   }
# }

# dependency gabe_identity_id {
#   config_path = "../../users/gabe"
#   mock_outputs = {
#     id = "abc-123"
#   }
# }

# dependency israel_identity_id {
#   config_path = "../../users/israel"
#   mock_outputs = {
#     id = "abc-123"
#   }
# }

# # These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# inputs = {
#   name                = "control-group-authority"
#   policies            = ["control-group-authority"]
#   member_entity_ids   = [
#     dependency.cam_identity_id.outputs.id,
#     dependency.gabe_identity_id.outputs.id,
#     dependency.israel_identity_id.outputs.id,
#   ]
# }
