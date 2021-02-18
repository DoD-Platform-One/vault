# -----------------------------------------------------------------------------
# List PKI roles on pki/il4/npe engine
# -----------------------------------------------------------------------------
path "pki/il4/npe/roles" {
  capabilities = ["list", "read"]
}

# -----------------------------------------------------------------------------
# Issue certificates from the il4-npe-leaf PKI role
# -----------------------------------------------------------------------------
#path "pki/il4/npe/issue/il4-npe-leaf" {
#  capabilities = ["update"]

#  control_group = {
#    factor "authorizer" {
#      identity {
#        group_names = [ "il4-npe-ca" ]
#        approvals   = 2
#      }
#    }
#  }
#}

# -----------------------------------------------------------------------------
# Sign CSRs with the il4-npe-leaf PKI role
# -----------------------------------------------------------------------------
path "pki/il4/npe/sign/il4-npe-leaf" {
  capabilities = ["update"]

  control_group = {
    factor "authorizer" {
      identity {
        group_names = [ "il4-npe-ca" ]
        approvals   = 2
      }
    }
  }
}
