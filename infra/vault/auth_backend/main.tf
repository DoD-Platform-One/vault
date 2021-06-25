resource "vault_auth_backend" "this" {
  type = var.type

  tune {
    max_lease_ttl      = var.max_lease_ttl
    default_lease_ttl  = var.default_lease_ttl
    listing_visibility = var.listing_visibility
  }
}
