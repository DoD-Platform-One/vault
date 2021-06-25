output "id" {
  description = "The id of the created identity_entity"
  value       = vault_identity_entity.user.id
}

output "identity_entity_name" {
  description = "The name of the created identity_entity"
  value       = vault_identity_entity.user.name
}
