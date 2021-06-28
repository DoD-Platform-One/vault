variable "userpass_username" {
  description = "(Required) Name of the alias. Name should be the identifier of the client in the authentication source"
  type        = string
}

variable "userpass_mount_accessor" {
  description = "(Required) Accessor of the mount to which the alias should belong to"
  type        = string
}

variable "id" {
  description = "Used as canonical ID of alias. You might us a vault_identity_entity ID for example."
  type        = string
}
