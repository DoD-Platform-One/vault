# -----------------------------------------------------------------------------
# List PKI roles on pki/p1_int_ca/int engine
# -----------------------------------------------------------------------------
path "pki/p1_int_ca/int/roles" {
  capabilities = ["list", "read"]
}

# P1 Intermediate CA will be unable to generate key pairs without this role
# -----------------------------------------------------------------------------
# Issue certificates from the p1-int-leaf PKI role
# -----------------------------------------------------------------------------
#path "pki/p1_int_ca/int/issue/p1-int-leaf" {
#  capabilities = ["update"]

#  control_group = {
#    factor "authorizer" {
#      identity {
#        group_names = [ "p1-int" ]
#        approvals   = 2
#      }
#    }
#  }
#}

#This requires a csr be submitted to the appropriate endpoint (MVP is only for Notary Int CA)
# -----------------------------------------------------------------------------
# Sign CSRs with the p1-int-leaf PKI role
# -----------------------------------------------------------------------------
#path "pki/p1_int_ca/int/sign/p1-int-leaf" {
#  capabilities = ["update"]
#
#  control_group = {
#    factor "authorizer" {
#      identity {
#        group_names = [ "p1-int" ]
#        approvals   = 2
#      }
#    }
#  }
#}
