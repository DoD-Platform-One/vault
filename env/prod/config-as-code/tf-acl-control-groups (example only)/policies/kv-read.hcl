path "kv/" {
  capabilities = ["list"]
}

path "kv/+" {
  capabilities = ["read"]

  control_group = {
    factor "authorizer" {
      identity {
        group_names = [ "sudoers" ]
        approvals   = 2
      }
    }
  }
}
