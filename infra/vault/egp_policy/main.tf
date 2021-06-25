resource "vault_egp_policy" "this" {
  name              = var.name
  paths             = var.paths
  enforcement_level = var.enforcement_level

  policy = var.policy
}
