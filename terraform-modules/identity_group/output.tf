output "group_members" {
  description = "A list of Entity IDs assigned as group members"
  value       = vault_identity_group.this.member_entity_ids
}

output "group_id" {
  description = "ID of the created group"
  value       = vault_identity_group.this.id
}
