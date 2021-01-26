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
    key            = "pki/terraform.tfstate"
  }
}
 
# Set config using environment variables
# See https://registry.terraform.io/providers/hashicorp/vault/latest/docs#provider-arguments
provider "vault" {
  address = "https://cubbyhole.cnap.dso.mil"
}