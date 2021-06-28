# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../terraform-modules/policy"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency group_id {
  config_path = "../../identity_control/groups/security_officer"
  mock_outputs = {
    group_id = "abc-123"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  name   = "vault-security officer"
  policy = <<EOT

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
path "identity/group/name/security_officer" {
  capabilities = ["read"]
}

path "identity/group/id/${dependency.group_id.outputs.group_id}" {
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
path "/pki/p1_int_ca/int/root/*" {
  capabilities = ["deny"]
}

path "/pki/il2/int/root/*" {
  capabilities = ["deny"]
}

path "/pki/il4/int/root/*" {
  capabilities = ["deny"]
}

path "/pki/il5/int/root/*" {
  capabilities = ["deny"]
}

path "/pki/il2/npe/root/*" {
  capabilities = ["deny"]
}

path "/pki/il4/npe/root/*" {
  capabilities = ["deny"]
}

path "/pki/il5/npe/root/*" {
  capabilities = ["deny"]
}

#future policy considerations
# -----------------------------------------------------------------------------
# Deny all on any secret mounted under the secrets/ path, e.g.:
#   secrets/kv/app-1
#   secrets/aws/iam-admin
# -----------------------------------------------------------------------------
#path "secrets/*" {
#  capabilities = ["deny"]
#}

#path "+/secrets/*" {
#  capabilities = ["deny"]
#}

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

path "/pki/p1_int_ca/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "/pki/il5/int/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "/pki/il4/int/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "/pki/il2/int/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "/pki/il5/npe/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "/pki/il4/npe/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "/pki/il2/npe/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

#future use case
# path "/kv/int/*" {
#   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
# }

# path "/kv/il5/*" {
#   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
# }

# path "/kv/il4/*" {
#   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
# }

# path "/kv/il2/*" {
#   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
# }


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

EOT
}
