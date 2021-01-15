terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "2.17.0"
    }
  }
}

resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

module "userpass_shobs" {
  depends_on = [vault_auth_backend.userpass]
  source     = "./modules/userpass-user"

  userpass_mount_accessor = vault_auth_backend.userpass.accessor
  userpass_username       = "sshastri"
  identity_entity_name    = "shobs"
}

module "userpass_johnny" {
  depends_on = [vault_auth_backend.userpass]
  source     = "./modules/userpass-user"

  userpass_mount_accessor = vault_auth_backend.userpass.accessor
  userpass_username       = "johnny"
  identity_entity_name    = "thejohnny"
}

module "userpass_cam" {
  depends_on = [vault_auth_backend.userpass]
  source     = "./modules/userpass-user"

  userpass_mount_accessor = vault_auth_backend.userpass.accessor
  userpass_username       = "cam"
  identity_entity_name    = "pidof"
}

module "userpass_gabe" {
  depends_on = [vault_auth_backend.userpass]
  source     = "./modules/userpass-user"

  userpass_mount_accessor = vault_auth_backend.userpass.accessor
  userpass_username       = "gabe"
  identity_entity_name    = "gscarberry"
}

module "userpass_israel" {
  depends_on = [vault_auth_backend.userpass]
  source     = "./modules/userpass-user"

  userpass_mount_accessor = vault_auth_backend.userpass.accessor
  userpass_username       = "israel"
  identity_entity_name    = "imorales"
}

resource "vault_identity_group" "sudoers" {
  name     = "sudoers"
  type     = "internal"
  policies = ["sudo"]

  member_entity_ids = [
    module.userpass_cam.vault_identity_entity_id,
    module.userpass_gabe.vault_identity_entity_id,
    module.userpass_israel.vault_identity_entity_id,
  ]
}

resource "vault_identity_group" "kv-read" {
  name     = "kv-readers"
  type     = "internal"
  policies = ["kv-read"]

  member_entity_ids = [
    module.userpass_shobs.vault_identity_entity_id,
    module.userpass_johnny.vault_identity_entity_id,
  ]
}

resource "vault_policy" "kv-read" {
  name   = "kv-read"
  policy = file("policies/kv-read.hcl")
}

resource "vault_policy" "sudo" {
  name   = "sudo"
  policy = file("policies/sudo.hcl")
}

resource "vault_policy" "change-userpass-password" {
  name = "change-userpass-password"
  policy = templatefile("policies/change-userpass-password.hcl",
    {
      userpass_mount_accessor = vault_auth_backend.userpass.accessor
    }
  )
}

resource "vault_mount" "demo-kv" {
  path = "demo-kv"
  type = "kv"

  # seal_wrap                = true
  # external_entropy_access  = true

  options = {
    version = 1
  }
}
