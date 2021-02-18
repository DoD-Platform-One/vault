# -----------------------------------------------------------------------------
# List PKI roles on pki/il5/int engine
# -----------------------------------------------------------------------------
path "pki/il5/int/roles" {
  capabilities = ["list", "read"]
}

# -----------------------------------------------------------------------------
# Issue certificates from the il5-leaf PKI role
# -----------------------------------------------------------------------------
#path "pki/il5/int/issue/il5-leaf" {
#  capabilities = ["update"]

#  control_group = {
#    factor "authorizer" {
#      identity {
#        group_names = [ "il5-int-ca" ]
#        approvals   = 2
#      }
#    }
#  }
#}

# -----------------------------------------------------------------------------
# Sign CSRs with the il5-leaf PKI role
# -----------------------------------------------------------------------------
#path "pki/il5/int/sign/il5-leaf" {
#  capabilities = ["update"]
#
#  control_group = {
#    factor "authorizer" {
#      identity {
#        group_names = [ "il5-int-ca" ]
#        approvals   = 2
#      }
#    }
#  }
#}
