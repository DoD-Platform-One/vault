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
    key            = "pki/p1_int/terraform.tfstate"
  }
}

# Set config using environment variables
# See https://registry.terraform.io/providers/hashicorp/vault/latest/docs#provider-arguments
provider "vault" {
  address = "https://cubbyhole.cnap.dso.mil"
}

# mount point for p1 intermediate ca
resource "vault_mount" "pki_p1_int" {
  path                    = "pki/int/p1_int"
  type                    = "pki"
  max_lease_ttl_seconds   = 94608000 # 3 years
  seal_wrap               = true
  external_entropy_access  = true
}

# generate p1 int ca csr
resource "vault_pki_secret_backend_intermediate_cert_request" "pki_p1_int" {
  backend = vault_mount.pki_p1_int.path

  type        = "internal"
  common_name = "DoD P1 Intermediate Certificate Authority"
  key_type    = "rsa"
  key_bits    = "4096"

  country      = "US"
  province     = "Colorado"
  locality     = "Colorado Springs"
  organization = "DoD Platform One"
}