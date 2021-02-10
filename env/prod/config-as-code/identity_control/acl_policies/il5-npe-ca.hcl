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
#        approvals   = 2
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
        approvals   = 2
      }
    }
  }
}
