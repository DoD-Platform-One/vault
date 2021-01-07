terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "2.17.0"
    }
    aws = {
      region  = "us-gov-west-1"
      profile = "235856440647_LevelUpAdmins"
    }
  }
 backend "s3" {
    encrypt        = true
    bucket         = "p1-cnap-vault-dev-tfstate-backend20210107181214364300000001"
    dynamodb_table = "p1-cnap-vault-dev-tfstate-backend"
    region         = "us-gov-west-1"
    key            = "il2-vault-app-state/terraform.tfstate"
    profile        = "235856440647_LevelUpAdmins"
  }
}


# Set config using environment variables
# See https://registry.terraform.io/providers/hashicorp/vault/latest/docs#provider-arguments
// provider "vault" {
//   address = "https://127.0.0.1:8200"
//   skip_tls_verify = true
// }