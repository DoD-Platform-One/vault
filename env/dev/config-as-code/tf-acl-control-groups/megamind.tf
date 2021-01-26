resource "vault_identity_entity" "jeff_mccoy" {
  name     = "megamind"
  policies = ["default", "change-userpass-password"]
  disabled = false
}

resource "vault_generic_endpoint" "megamind" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/megamind"
  ignore_absent_fields = true

  data_json = jsonencode(
    {
      "policies" : ["default"],
      "password" : "hunter2"
    }
  )
}

resource "vault_identity_entity_alias" "megamind" {
  name           = "megamind"
  mount_accessor = vault_auth_backend.userpass.accessor
  canonical_id   = vault_identity_entity.jeff_mccoy.id
}
