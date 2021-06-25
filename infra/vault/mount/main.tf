# specfic mount point for individual pki or kv mount
resource "vault_mount" "this" {
  path                      = var.mount_path        #"pki/int/p1_int"
  type                      = var.mount_type        #"pki"
  description               = var.description       #mount for intermediate CA
  default_lease_ttl_seconds = var.default_mount_ttl #94608000 # 3 years
  max_lease_ttl_seconds     = var.max_mount_ttl     #94608000 # 3 years
  seal_wrap                 = var.seal_wrap         #true
  external_entropy_access   = var.external_entropy  #true
  #options                  = (Optional) Specifies mount type specific options that are passed to the backend
}
