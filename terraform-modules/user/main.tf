resource "vault_identity_entity" "user" {
  name = var.identity_entity_name
  policies = flatten(
    distinct(
      concat(["default"], var.identity_entity_policies)
    )
  )
  disabled = false
  #metadata = var.identity_entity_metadata
}

resource "vault_identity_entity_alias" "user" {
  name           = var.userpass_username
  mount_accessor = var.auth_backend
  canonical_id   = vault_identity_entity.user.id
}

resource "vault_policy" "change-userpass-password" {
  name = "change-userpass-password"
  policy = templatefile("change-userpass-password.hcl.tpl",
    {
      userpass_mount_accessor = var.auth_backend
    }
  )
}

resource "random_password" "this" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "vault_generic_endpoint" "user" {
  path                 = "auth/userpass/users/${var.userpass_username}"
  ignore_absent_fields = true

  data_json = jsonencode(
    {
      "policies" : ["default"],
      "password" : random_password.this.result
    }
  )
}
