# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/policy"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  name   = "il5-npe-ca"
  policy = <<EOT
# -----------------------------------------------------------------------------
# List PKI roles on pki/il5/npe engine
# -----------------------------------------------------------------------------
path "pki/il5/npe/roles" {
  capabilities = ["list", "read"]
}

# -----------------------------------------------------------------------------
# Issue certificates from the il5-npe-leaf PKI role
# -----------------------------------------------------------------------------
#path "pki/il5/npe/issue/il5-npe-leaf" {
#  capabilities = ["update"]

#  control_group = {
#    factor "authorizer" {
#      identity {
#        group_names = [ "il5-npe-ca" ]
#        approvals   = 1
#      }
#    }
#  }
#}

# -----------------------------------------------------------------------------
# Sign CSRs with the il5-npe-leaf PKI role
# -----------------------------------------------------------------------------
path "pki/il5/npe/sign/il5-npe-leaf" {
  capabilities = ["update"]

  control_group = {
    factor "authorizer" {
      identity {
        group_names = [ "il5-npe-ca" ]
        approvals   = 1
      }
    }
  }
}

EOT
}
