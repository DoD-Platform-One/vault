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
