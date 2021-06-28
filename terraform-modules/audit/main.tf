resource "vault_audit" "this" {
  type        = var.type
  path        = var.path
  description = var.description
  local       = var.local
  options     = var.options
}