output "path" {
  description = "path modified"
  value       = vault_generic_endpoint.this.path
}

output "id" {
  description = "path modified"
  value       = vault_generic_endpoint.this.id
}

// output write_data {
//   description = " A map whose keys are the top-level data keys returned from Vault by the write operation and whose values are the corresponding values. This map can only represent string data, so any non-string values returned from Vault are serialized as JSON. Only fields set in write_fields are present in the JSON data."
//   value = vault_generic_endpoint.this.write_data.write_fields
// }