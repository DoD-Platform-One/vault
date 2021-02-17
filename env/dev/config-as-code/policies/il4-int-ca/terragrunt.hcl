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
  name   = "il4-int-ca"
  policy = <<EOT
# -----------------------------------------------------------------------------
# List PKI roles on pki/il4/int engine
# -----------------------------------------------------------------------------
path "pki/il4/int/roles" {
  capabilities = ["list", "read"]
}

# -----------------------------------------------------------------------------
# Issue certificates from the il4-int-leaf PKI role
# -----------------------------------------------------------------------------
#path "pki/il4/int/issue/il4-int-leaf" {
#  capabilities = ["update"]

#  control_group = {
#    factor "authorizer" {
#      identity {
#        group_names = [ "il4-int-ca" ]
#        approvals   = 1
#      }
#    }
#  }
#}

# -----------------------------------------------------------------------------
# Sign CSRs with the il4-int-leaf PKI role
# -----------------------------------------------------------------------------
# path "pki/il4/int/sign/il4-int-leaf" {
#   capabilities = ["update"]

#   control_group = {
#     factor "authorizer" {
#       identity {
#         group_names = [ "il4-int-ca" ]
#         approvals   = 1
#       }
#     }
#   }
# }

EOT
}
