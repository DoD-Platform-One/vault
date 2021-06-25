resource "vault_identity_entity" "chad_elkins" {
  name     = "thechad"
  policies = ["default", "change-userpass-password"]
  disabled = false
}

resource "vault_generic_endpoint" "chad" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/chad"
  ignore_absent_fields = true

  data_json = jsonencode(
    {
      "policies" : ["default"],
      "password" : "hunter2"
    }
  )
}

resource "vault_identity_entity_alias" "chad" {
  name           = "chad"
  mount_accessor = vault_auth_backend.userpass.accessor
  canonical_id   = vault_identity_entity.chad_elkins.id
}
