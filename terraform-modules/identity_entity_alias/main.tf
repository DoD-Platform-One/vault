resource "vault_identity_entity_alias" "user" {
  name           = var.userpass_username
  mount_accessor = var.userpass_mount_accessor
  canonical_id   = var.id #vault_identity_entity.user.id
}
