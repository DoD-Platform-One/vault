# resource "vault_identity_entity" "johnny_carlin" {
#   name     = "thejohnny"
#   policies = ["default", "change-userpass-password"]
#   disabled = false
# }

# resource "vault_generic_endpoint" "johnny" {
#   depends_on           = [vault_auth_backend.userpass]
#   path                 = "auth/userpass/users/johnny"
#   ignore_absent_fields = true

#   data_json = jsonencode(
#     {
#       "policies" : ["default"],
#       "password" : "hunter2"
#     }
#   )
# }

# resource "vault_identity_entity_alias" "johnny" {
#   name           = "johnny"
#   mount_accessor = vault_auth_backend.userpass.accessor
#   canonical_id   = vault_identity_entity.johnny_carlin.id
# }
