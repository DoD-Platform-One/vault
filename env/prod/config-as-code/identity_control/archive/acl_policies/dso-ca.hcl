# -----------------------------------------------------------------------------
# List PKI roles on pki/dso/int engine
# -----------------------------------------------------------------------------
path "pki/dso/int/roles" {
  capabilities = ["list", "read"]
}

# -----------------------------------------------------------------------------
# Issue certificates from the dso-leaf PKI role
# -----------------------------------------------------------------------------
#path "pki/dso/int/issue/dso-leaf" {
#  capabilities = ["update"]

#  control_group = {
#    factor "authorizer" {
#      identity {
#        group_names = [ "dso-ca" ]
#        approvals   = 1
#      }
#    }
#  }
#}

# -----------------------------------------------------------------------------
# Sign CSRs with the dso-leaf PKI role
# -----------------------------------------------------------------------------
path "pki/dso/int/sign/dso-leaf" {
  capabilities = ["update"]

  control_group = {
    factor "authorizer" {
      identity {
        group_names = [ "dso-ca" ]
        approvals   = 1
      }
    }
  }
}
