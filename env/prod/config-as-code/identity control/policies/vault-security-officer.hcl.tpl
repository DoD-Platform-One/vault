# Permissions for cluster-level security concerns of the Vault service, such
# as managing administrative auth methods and associated policies, 
# revoking/generating `root` tokens, and rekey/rotate operations.

# Requires root token to modify policy

# -----------------------------------------------------------------------------
# Read-only access to vault-security-officer policy
# -----------------------------------------------------------------------------
path "sys/policies/acl/vault-security-officer" {
  capabilities = ["read"]
}

# -----------------------------------------------------------------------------
# Read-only access to the vault-security-officers identity group
# -----------------------------------------------------------------------------
path "identity/group/name/${group_name}" {
  capabilities = ["read"]
}

path "identity/group/id/${group_id}" {
  capabilities = ["read"]
}

# -----------------------------------------------------------------------------
# Deny creation, removal or changes to audit devices
# -----------------------------------------------------------------------------
path "sys/audit/*" {
  capabilities = ["deny"]
}

# -----------------------------------------------------------------------------
# Deny use of root endpoints on PKI mounts
# -----------------------------------------------------------------------------
path "/pki/il5/p1_root/root/*" {
  capabilities = ["deny"]
}

path "/pki/il5/p1_int/root/*" {
  capabilities = ["deny"]
}

# -----------------------------------------------------------------------------
# Deny all on any secret mounted under the secrets/ path, e.g.:
#   secrets/kv/app-1
#   secrets/aws/iam-admin
# -----------------------------------------------------------------------------
path "secrets/*" {
  capabilities = ["deny"]
}

path "+/secrets/*" {
  capabilities = ["deny"]
}

# -----------------------------------------------------------------------------
# Manage identity secrets broadly across Vault (root namespace)
# -----------------------------------------------------------------------------
path "identity/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# -----------------------------------------------------------------------------
# Manage auth backends broadly across Vault (root namespace)
# -----------------------------------------------------------------------------
path "auth/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# -----------------------------------------------------------------------------
# List, create, update, and delete auth backends excluding userpass (root ns)
# -----------------------------------------------------------------------------
path "sys/auth" {
  capabilities = ["read"]
}

path "sys/auth/*" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

# -----------------------------------------------------------------------------
# List policies (root namespace)
# -----------------------------------------------------------------------------
path "sys/policy" {
  capabilities = ["read"]
}

# -----------------------------------------------------------------------------
# Create and manage ACL policies broadly across Vault (root namespace)
# -----------------------------------------------------------------------------
path "sys/policies/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}


# -----------------------------------------------------------------------------
# List mounted secrets engines (root namespace)
# -----------------------------------------------------------------------------
path "sys/mounts" {
  capabilities = ["read"]
}

path "sys/internal/ui/mounts" {
  capabilities = ["read"]
}

path "/pki/il5/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "/pki/il4/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "/pki/il2/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "/kv/il5/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "/kv/il4/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "/kv/il2/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}


# -----------------------------------------------------------------------------
# Manage secret backends broadly across Vault (root namespace)
# -----------------------------------------------------------------------------
path "sys/mounts/*"{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# -----------------------------------------------------------------------------
# Manage namespaces broadly across Vault
# -----------------------------------------------------------------------------
path "sys/namespaces/" {
  capabilities = ["list"]
}

path "sys/namespaces/*" {
  capabilities = ["read", "update", "delete"]
}

# -----------------------------------------------------------------------------
# Read health checks (root namespace)
# -----------------------------------------------------------------------------
path "sys/health" {
  capabilities = ["read", "sudo"]
}

# -----------------------------------------------------------------------------
# Fetch the capabilities of a token
# -----------------------------------------------------------------------------
path "sys/capabilities" {
  capabilities = ["update"]
}
