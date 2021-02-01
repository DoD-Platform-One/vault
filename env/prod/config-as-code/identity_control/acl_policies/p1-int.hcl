# -----------------------------------------------------------------------------
# List PKI roles on pki/int/p1_int engine
# -----------------------------------------------------------------------------
path "pki/int/p1_int/roles" {
  capabilities = ["list", "read"]
}

# P1 Intermediate CA will be unable to generate key pairs without this role
# -----------------------------------------------------------------------------
# Issue certificates from the p1-leaf-cert PKI role
# -----------------------------------------------------------------------------
#path "pki/int/p1_int/issue/p1-leaf-cert" {
#  capabilities = ["update"]

#  control_group = {
#    factor "authorizer" {
#      identity {
#        group_names = [ "int-p1-int" ]
#        approvals   = 2
#      }
#    }
#  }
#}

#This requires a csr be submitted to the appropriate endpoint (MVP is only for Notary Int CA)
# -----------------------------------------------------------------------------
# Sign CSRs with the p1-leaf-cert PKI role
# -----------------------------------------------------------------------------
path "pki/int/p1_int/sign/p1-leaf-cert" {
  capabilities = ["update"]

  control_group = {
    factor "authorizer" {
      identity {
        group_names = [ "int-p1-int" ]
        approvals   = 2
      }
    }
  }
}
