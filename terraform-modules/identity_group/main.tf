resource "vault_identity_group" "this" {
  name     = var.name
  type     = "internal"
  policies = var.policies

  member_entity_ids = var.member_entity_ids
  #metadata = var.metadata
}
