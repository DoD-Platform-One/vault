# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/policy?ref=vault"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  name   = "p1-int-ca"
  policy = <<EOT
# -----------------------------------------------------------------------------
# List PKI roles on pki/p1_int_ca/int engine
# -----------------------------------------------------------------------------
path "pki/p1_int_ca/int/roles" {
  capabilities = ["list", "read"]
}

# -----------------------------------------------------------------------------
# Issue certificates from the p1_int-leaf PKI role
# -----------------------------------------------------------------------------
#path "pki/p1_int_ca/int/issue/p1_int-leaf" {
#  capabilities = ["update"]

#  control_group = {
#    factor "authorizer" {
#      identity {
#        group_names = [ "p1-int-ca" ]
#        approvals   = 1
#      }
#    }
#  }
#}

# -----------------------------------------------------------------------------
# Sign CSRs with the p1_int-leaf PKI role
# -----------------------------------------------------------------------------
# path "pki/p1_int_ca/int/sign/p1_int-leaf" {
#  capabilities = ["update"]

#  control_group = {
#    factor "authorizer" {
#      identity {
#        group_names = [ "p1-int-ca" ]
#        approvals   = 1
#      }
#    }
#  }
# }

EOT
}
