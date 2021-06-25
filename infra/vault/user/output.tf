output "id" {
  description = "The id of the created identity_entity"
  value       = vault_identity_entity.user.id
}

output "identity_entity_name" {
  description = "The name of the created identity_entity"
  value       = vault_identity_entity.user.name
}

output "password" {
  description = "The randomly generated password from the random provider"
  value       = vault_generic_endpoint.user.data_json
}
