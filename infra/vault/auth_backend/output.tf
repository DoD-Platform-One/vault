output "accessor" {
  description = "The accessor for this auth method"
  value       = vault_auth_backend.this.accessor
}