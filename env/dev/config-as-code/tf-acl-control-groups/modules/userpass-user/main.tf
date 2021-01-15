resource "vault_identity_entity" "user" {
  name     = var.identity_entity_name
  policies = ["default", "change-userpass-password"]
  disabled = false
}

resource "vault_generic_endpoint" "user" {
  path                 = "auth/userpass/users/${var.userpass_username}"
  ignore_absent_fields = true

  data_json = jsonencode(
    {
      "policies" : ["default"],
      "password" : "hunter2"
    }
  )
}

resource "vault_identity_entity_alias" "user" {
  name           = var.userpass_username
  mount_accessor = var.userpass_mount_accessor
  canonical_id   = vault_identity_entity.user.id
}

output "vault_identity_entity_id" {
  value = vault_identity_entity.user.id
}