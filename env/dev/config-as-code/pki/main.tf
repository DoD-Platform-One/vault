terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "2.17.0"
    }
  }
}
 
provider "aws" {      
  region  = "us-gov-west-1"
  profile = "arn:aws-us-gov:iam::526389029191:instance-profile/vault-bastion-profile"
    
  backend "s3" {
    encrypt        = true
    bucket         = "p1-cnap-vault-prod-tfstate-backend20210120202801559700000001"
    dynamodb_table = "p1-cnap-vault-prod-tfstate-backend"
    region         = "us-gov-west-1"
    key            = "pki/p1_int/terraform.tfstate"
    profile        = "arn:aws-us-gov:iam::526389029191:instance-profile/vault-bastion-profile"
  }
}

# Set config using environment variables
# See https://registry.terraform.io/providers/hashicorp/vault/latest/docs#provider-arguments
provider "vault" {
  address = "https://cubbyhole.cnap.dso.mil"
}