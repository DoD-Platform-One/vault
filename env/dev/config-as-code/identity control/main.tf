terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "2.17.0"
    }
  }
}

# Set config using environment variables
# See https://registry.terraform.io/providers/hashicorp/vault/latest/docs#provider-arguments

variable login_username {}
variable login_password {}

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

resource "vault_identity_entity" "cameron.banowsky" {
  name      = "pidof"
  policies  = ["admin"]
  disabled = false
}

resource "vault_identity_entity" "israel.morales" {
  name      = "imorales"
  policies  = ["admin"]
  disabled = false
}

resource "vault_identity_entity" "gabe.scarberry" {
  name      = "gscarberry"
  policies  = ["admin"]
  disabled = false
}

resource "vault_identity_group" "admin" {
  name     = "admin"
  type     = "internal"
  policies = ["admin", "dev", "staging", "prod"]

  metadata = {
    version = "2"
  }
}

resource "vault_identity_group_policies" "admin" {
  policies = ["admin"]

  group_id = vault_identity_group.internal.id
}

resource "vault_identity_group" "internal" {
  name     = "internal"
  type     = "internal"
  policies = ["dev", "staging", "prod"]
}

resource "vault_identity_group_policies" "internal" {
  policies = ["internal"]

  group_id = vault_identity_group.internal.id
}

resource "vault_identity_group" "dev" {
  name     = "dev"
  type     = "internal"
  policies = ["dev"]
}

resource "vault_identity_group_policies" "dev" {
  policies = ["dev"]

  exclusive = false

  group_id = vault_identity_group.internal.id
}


data "vault_policy_document" "admin" {
  rule {
    path         = "secret/*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "allow all on secrets under admin"
  }
}

resource "vault_policy" "admin" {
  name     = "admin_policy"
  policy   = data.vault_policy_document.vault_admin_secrets.hcl
}

data "vault_policy_document" "internal" {
  rule {
    path         = ["secret/dev*", "secret/staging/*", "secret/prod/*"]
    capabilities = ["create", "read"]
    description  = "allow create / read secrets for dev, staging and prod"
  }
}

resource "vault_policy" "internal" {
  name     = "internal_policy"
  policy   = data.vault_policy_document.vault_internal_secrets.hcl
}

data "vault_policy_document" "dev" {
  rule {
    path         = ["secret/dev*"]
    capabilities = ["create", "read"]
    description  = "allow create / read secrets for dev"
  }
}

resource "vault_policy" "dev" {
  name     = "dev_policy"
  policy   = data.vault_policy_document.vault_dev_secrets.hcl
}