path "kv/+" {
  capabilities = ["list", "create", "update"]

  control_group = {
    factor "authorizer" {
      identity {
        group_names = [ "sudoers" ]
        approvals   = 1
      }
    }
  }
}
