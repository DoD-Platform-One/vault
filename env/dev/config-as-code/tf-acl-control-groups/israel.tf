# resource "vault_identity_entity" "israel_morales" {
#   name     = "imorales"
#   policies = ["default", "change-userpass-password"]
#   disabled = false
# }

# resource "vault_generic_endpoint" "israel" {
#   depends_on           = [vault_auth_backend.userpass]
#   path                 = "auth/userpass/users/israel"
#   ignore_absent_fields = true

#   data_json = jsonencode(
#     {
#       "policies" : ["default"],
#       "password" : "hunter2"
#     }
#   )
# }

# resource "vault_identity_entity_alias" "israel" {
#   name           = "israel"
#   mount_accessor = vault_auth_backend.userpass.accessor
#   canonical_id   = vault_identity_entity.israel_morales.id
# }
