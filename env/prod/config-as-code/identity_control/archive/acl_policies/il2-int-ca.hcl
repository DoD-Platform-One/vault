# -----------------------------------------------------------------------------
# List PKI roles on pki/il2/int engine
# -----------------------------------------------------------------------------
path "pki/il2/int/roles" {
  capabilities = ["list", "read"]
}

# -----------------------------------------------------------------------------
# Issue certificates from the il2-leaf PKI role
# -----------------------------------------------------------------------------
#path "pki/il2/int/issue/il2-leaf" {
#  capabilities = ["update"]

#  control_group = {
#    factor "authorizer" {
#      identity {
#        group_names = [ "il2-int-ca" ]
#        approvals   = 1
#      }
#    }
#  }
#}

# -----------------------------------------------------------------------------
# Sign CSRs with the il2-leaf PKI role
# -----------------------------------------------------------------------------
#path "pki/il2/int/sign/il2-leaf" {
#  capabilities = ["update"]
#
#  control_group = {
#    factor "authorizer" {
#      identity {
#        group_names = [ "il2-int-ca" ]
#        approvals   = 1
#      }
#    }
#  }
#}
