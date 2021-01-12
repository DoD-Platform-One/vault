# resource "vault_identity_entity" "cameron_banowsky" {
#   name     = "pidof"
#   policies = ["default", "change-userpass-password"]
#   disabled = false
# }

# resource "vault_generic_endpoint" "cam" {
#   depends_on           = [vault_auth_backend.userpass]
#   path                 = "auth/userpass/users/cam"
#   ignore_absent_fields = true

#   data_json = jsonencode(
#     {
#       "policies" : ["default"],
#       "password" : "hunter2"
#     }
#   )
# }

# resource "vault_identity_entity_alias" "cam" {
#   name           = "cam"
#   mount_accessor = vault_auth_backend.userpass.accessor
#   canonical_id   = vault_identity_entity.cameron_banowsky.id
# }
