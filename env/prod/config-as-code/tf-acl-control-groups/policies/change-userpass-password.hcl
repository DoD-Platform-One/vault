# Allow users to change their own userpass password

path "auth/userpass/users/{{ identity.entity.aliases.${userpass_mount_accessor}.name }}/password" {
  capabilities = [ "update" ]

  allowed_parameters = {
    "password" = []
  }
}