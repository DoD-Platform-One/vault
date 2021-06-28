resource "vault_policy" "this" {
  name   = var.name
  policy = var.policy
}
