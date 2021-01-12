path "demo-kv/" {
  capabilities = ["list"]
}

path "demo-kv/+" {
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
