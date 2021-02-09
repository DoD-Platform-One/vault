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
    key            = "identity_control/terraform.tfstate"
  }
}
 
# Set config using environment variables
# See https://registry.terraform.io/providers/hashicorp/vault/latest/docs#provider-arguments
provider "vault" {
  address = "https://cubbyhole.cnap.dso.mil"
}
# Set config using environment variables
# See https://registry.terraform.io/providers/hashicorp/vault/latest/docs#provider-arguments

# variable login_username {}
# variable login_password {}

#this would go in main.tf
#need to verify these are not stored in the tfstate file

provider "vault" {
  alias = "admin"
  auth_login {
    path = "auth/userpass/login/${var.login_username}"

    parameters = {
      password = var.login_password
    }
  }
}

resource "vault_auth_backend" "userpass" {
  type = "userpass"
  tune {
    default_lease_ttl = "12m"
    max_lease_ttl     = "60m"
  }
}

module "userpass_cam" {
  depends_on = [vault_auth_backend.userpass]
  source     = "./modules/userpass-user"

  userpass_mount_accessor  = vault_auth_backend.userpass.accessor
  userpass_username        = "cam"
  userpass_password        = "hunter2"
  identity_entity_name     = "pidof"
  identity_entity_policies = ["change-userpass-password"]
}

module "userpass_gabe" {
  depends_on = [vault_auth_backend.userpass]
  source     = "./modules/userpass-user"

  userpass_mount_accessor  = vault_auth_backend.userpass.accessor
  userpass_username        = "gabe"
  userpass_password        = "hunter2"
  identity_entity_name     = "gscarberry"
  identity_entity_policies = ["change-userpass-password"]
}

module "userpass_israel" {
  depends_on = [vault_auth_backend.userpass]
  source     = "./modules/userpass-user"

  userpass_mount_accessor  = vault_auth_backend.userpass.accessor
  userpass_username        = "israel"
  userpass_password        = "hunter2"
  identity_entity_name     = "imorales"
  identity_entity_policies = ["change-userpass-password"]
}

resource "vault_identity_group" "notary" {
  name     = "notary"
  type     = "internal"
  policies = ["p1-int"]

  member_entity_ids = [
    module.userpass_cam.vault_identity_entity_id,
    module.userpass_gabe.vault_identity_entity_id,
    module.userpass_israel.vault_identity_entity_id,
  ]
}

resource "vault_identity_group" "il5-p1-int" {
  name     = "il5-p1-int"
  type     = "internal"
  policies = ["il5-p1-int"]

  member_entity_ids = [
    module.userpass_cam.vault_identity_entity_id,
    module.userpass_gabe.vault_identity_entity_id,
    module.userpass_israel.vault_identity_entity_id,
  ]
}

resource "vault_identity_group" "il4-p1-int" {
  name     = "il4-p1-int"
  type     = "internal"
  policies = ["il4-p1-int"]

  member_entity_ids = [
    module.userpass_cam.vault_identity_entity_id,
    module.userpass_gabe.vault_identity_entity_id,
    module.userpass_israel.vault_identity_entity_id,
  ]
}

resource "vault_identity_group" "il2-p1-int" {
  name     = "il2-p1-int"
  type     = "internal"
  policies = ["il2-p1-int"]

  member_entity_ids = [
    module.userpass_cam.vault_identity_entity_id,
    module.userpass_gabe.vault_identity_entity_id,
    module.userpass_israel.vault_identity_entity_id,
  ]
}

resource "vault_identity_group" "control-group-authorities" {
  name     = "control-group-authorities"
  type     = "internal"
  policies = ["control-group-authority"]

  member_entity_ids = [
    module.userpass_cam.vault_identity_entity_id,
    module.userpass_gabe.vault_identity_entity_id,
    module.userpass_israel.vault_identity_entity_id,
  ]
}

resource "vault_identity_group" "vault-operators" {
  name     = "vault-operators"
  type     = "internal"
  policies = ["vault-operator"]

  member_entity_ids = []
}

resource "vault_identity_group" "vault-security-officers" {
  name     = "vault-security-officers"
  type     = "internal"
  policies = ["vault-security-officer"]

  member_entity_ids = [
    module.userpass_cam.vault_identity_entity_id,
    module.userpass_gabe.vault_identity_entity_id,
    module.userpass_israel.vault_identity_entity_id,
  ]
}

resource "vault_identity_group" "sudo" {
  name     = "sudo"
  type     = "internal"
  policies = ["sudo"]

  member_entity_ids = [
    module.userpass_cam.vault_identity_entity_id,
    module.userpass_gabe.vault_identity_entity_id,
    module.userpass_israel.vault_identity_entity_id,
  ]
}

resource "vault_policy" "p1-int" {
  name   = "p1-int"
  policy = file("acl_policies/p1-int.hcl")
}

resource "vault_policy" "il4-p1-int" {
  name   = "il4-p1-int"
  policy = file("acl_policies/il4-p1-int.hcl")
}

resource "vault_policy" "il2-p1-int" {
  name   = "il2-p1-int"
  policy = file("acl_policies/il2-p1-int.hcl")
}

resource "vault_policy" "control-group-authority" {
  name   = "control-group-authority"
  policy = file("acl_policies/control-group-authority.hcl")
}

resource "vault_policy" "change-userpass-password" {
  name = "change-userpass-password"
  policy = templatefile("acl_policies/change-userpass-password.hcl.tpl",
    {
      userpass_mount_accessor = vault_auth_backend.userpass.accessor
    }
  )
}

resource "vault_policy" "sudo" {
  name   = "sudo"
  policy = file("acl_policies/sudo.hcl")
}

resource "vault_policy" "vault-operator" {
  name   = "vault-operator"
  policy = file("acl_policies/vault-operator.hcl")
}

resource "vault_policy" "vault-security-officer" {
  name = "vault-security-officer"
  policy = templatefile("acl_policies/vault-security-officer.hcl.tpl",
    {
      policy_name = "vault-security-officer"
      group_name  = vault_identity_group.vault-security-officers.name
      group_id    = vault_identity_group.vault-security-officers.id
    }
  )
}
