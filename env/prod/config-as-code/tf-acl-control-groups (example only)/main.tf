terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "2.17.0"
    }
  } 
  backend "s3" {
    encrypt        = true
    bucket         = "p1-cnap-vault-prod-tfstate-backend20210120202801559700000001"
    dynamodb_table = "p1-cnap-vault-prod-tfstate-backend"
    region         = "us-gov-west-1"
    key            = "tf-acl-control-groups/terraform.tfstate"
  }
}
 
# Set config using environment variables
# See https://registry.terraform.io/providers/hashicorp/vault/latest/docs#provider-arguments
provider "vault" {
  address = "https://cubbyhole.cnap.dso.mil"
}

resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

module "userpass_jeff" {
  depends_on = [vault_auth_backend.userpass]
  source     = "./modules/userpass-user"

  userpass_mount_accessor = vault_auth_backend.userpass.accessor
  userpass_username       = "megamind"
  identity_entity_name    = "megamind"
}

module "userpass_chad" {
  depends_on = [vault_auth_backend.userpass]
  source     = "./modules/userpass-user"

  userpass_mount_accessor = vault_auth_backend.userpass.accessor
  userpass_username       = "chad.elkins"
  identity_entity_name    = "chad"
}

module "userpass_cam" {
  depends_on = [vault_auth_backend.userpass]
  source     = "./modules/userpass-user"

  userpass_mount_accessor = vault_auth_backend.userpass.accessor
  userpass_username       = "cameron.banowski"
  identity_entity_name    = "pidof"
}

module "userpass_gabe" {
  depends_on = [vault_auth_backend.userpass]
  source     = "./modules/userpass-user"

  userpass_mount_accessor = vault_auth_backend.userpass.accessor
  userpass_username       = "gabe.scarberry"
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
    module.userpass_jeff.vault_identity_entity_id,
    module.userpass_chad.vault_identity_entity_id,
  ]
}

resource "vault_identity_group" "kv-read" {
  name     = "kv-readers"
  type     = "internal"
  policies = ["kv-read"]

  member_entity_ids = [
    module.userpass_cam.vault_identity_entity_id,
    module.userpass_gabe.vault_identity_entity_id,
    module.userpass_israel.vault_identity_entity_id,
    module.userpass_jeff.vault_identity_entity_id,
    module.userpass_chad.vault_identity_entity_id,
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

resource "vault_mount" "kv" {
  path = "kv"
  type = "kv"

  seal_wrap                = true
  # external_entropy_access  = true

  options = {
    version = 1
  }
}
