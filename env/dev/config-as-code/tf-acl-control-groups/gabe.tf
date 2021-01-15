# resource "vault_identity_entity" "gabe_scarberry" {
#   name     = "gscarberry"
#   policies = ["default", "change-userpass-password"]
#   disabled = false
# }

# resource "vault_generic_endpoint" "gabe" {
#   depends_on           = [vault_auth_backend.userpass]
#   path                 = "auth/userpass/users/gabe"
#   ignore_absent_fields = true

#   data_json = jsonencode(
#     {
#       "policies" : ["default"],
#       "password" : "hunter2"
#     }
#   )
# }

# resource "vault_identity_entity_alias" "gabe" {
#   name           = "gabe"
#   mount_accessor = vault_auth_backend.userpass.accessor
#   canonical_id   = vault_identity_entity.gabe_scarberry.id
# }
