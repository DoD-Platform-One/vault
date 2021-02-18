# -----------------------------------------------------------------------------
# List PKI roles on pki/il2/npe engine
# -----------------------------------------------------------------------------
path "pki/il2/npe/roles" {
  capabilities = ["list", "read"]
}

# -----------------------------------------------------------------------------
# Issue certificates from the il2-npe-leaf PKI role
# -----------------------------------------------------------------------------
#path "pki/il2/npe/issue/il2-npe-leaf" {
#  capabilities = ["update"]

#  control_group = {
#    factor "authorizer" {
#      identity {
#        group_names = [ "il2-npe-ca" ]
#        approvals   = 2
#      }
#    }
#  }
#}

# -----------------------------------------------------------------------------
# Sign CSRs with the il2-npe-leaf PKI role
# -----------------------------------------------------------------------------
path "pki/il2/npe/sign/il2-npe-leaf" {
  capabilities = ["update"]

  control_group = {
    factor "authorizer" {
      identity {
        group_names = [ "il2-npe-ca" ]
        approvals   = 2
      }
    }
  }
}
