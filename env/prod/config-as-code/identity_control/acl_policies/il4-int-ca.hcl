# -----------------------------------------------------------------------------
# List PKI roles on pki/il4/int engine
# -----------------------------------------------------------------------------
path "pki/il4/int/roles" {
  capabilities = ["list", "read"]
}

# -----------------------------------------------------------------------------
# Issue certificates from the il4-leaf PKI role
# -----------------------------------------------------------------------------
#path "pki/il4/int/issue/il4-leaf" {
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
# Sign CSRs with the il4-leaf PKI role
# -----------------------------------------------------------------------------
#path "pki/il4/int/sign/il4-leaf" {
#  capabilities = ["update"]
#
#  control_group = {
#    factor "authorizer" {
#      identity {
#        group_names = [ "il4-int-ca" ]
#        approvals   = 1
#      }
#    }
#  }
#}
