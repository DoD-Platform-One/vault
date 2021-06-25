# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/policy"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  name   = "vault-operator"
  policy = <<EOT
# Permissions for cluster-level operational concerns of the Vault service, 
# such as maintaining the health of a cluster, performing upgrades, and 
# establishing replication relationships between clusters.
#
# Optimized for single-user operations

# -----------------------------------------------------------------------------
# Manage cluster license
# -----------------------------------------------------------------------------
path "sys/license" {
  capabilities = ["list", "read", "create", "update"]
}

# -----------------------------------------------------------------------------
# Manage plugins
# -----------------------------------------------------------------------------
path "sys/plugins/*" {
  capabilities = ["list", "read", "create", "update", "delete", "sudo"]
}

# -----------------------------------------------------------------------------
# Manage cluster replication
# -----------------------------------------------------------------------------
path "sys/replication/*" {
  capabilities = ["list", "read", "create", "update", "delete", "sudo"]
}

# -----------------------------------------------------------------------------
# Step down leader
# (Sometimes used during maintenance operations or for troubleshooting)
# -----------------------------------------------------------------------------
path "sys/step-down" {
  capabilities = ["create", "update", "sudo"]
}

# -----------------------------------------------------------------------------
# Manage storage backends
# (Currently only used to manage Raft storage backend)
# -----------------------------------------------------------------------------
path "sys/storage/raft/*" {
  capabilities = ["list", "read", "create", "update"]
}

# -----------------------------------------------------------------------------
# Read all mounted auth methods (root namespace)
# -----------------------------------------------------------------------------
path "auth/*" {
  capabilities = ["list", "read"]
}

# -----------------------------------------------------------------------------
# Read all system backend endpoints (root namespace)
# -----------------------------------------------------------------------------
path "sys/*" {
  capabilities = ["list", "read"]
}

# -----------------------------------------------------------------------------
# Read all mounted auth methods (tenant namespaces)
# -----------------------------------------------------------------------------
path "+/auth/*" {
  capabilities = ["list", "read"]
}

# -----------------------------------------------------------------------------
# Read all system backend endpoints (tenant namespaces)
# -----------------------------------------------------------------------------
path "+/sys/*" {
  capabilities = ["list", "read"]
}

# -----------------------------------------------------------------------------
# Vault UI capability checks within tenant namespaces
# -----------------------------------------------------------------------------
path "+/sys/capabilities-self" {
  capabilities = ["update"]
}

EOT
}