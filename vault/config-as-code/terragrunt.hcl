locals {
  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
}

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "your-bucket-here"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-gov-west-1"
    dynamodb_table = "your-dynamodb-table-here"
  }
}

generate "provider" {
  path      = "tg.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "vault" {
    address = "https://vault.bb.dev"
}

terraform {
    backend "s3" {}
}
EOF
}

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# inputs = merge(
#   local.region_vars.locals
# )