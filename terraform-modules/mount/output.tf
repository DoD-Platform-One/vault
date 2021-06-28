output "path" {
  description = "Where the secret backend will be mounted"
  value       = vault_mount.this.path
}
