variable "userpass_mount_accessor" {
  type        = string
  description = "Mount accessor for userpass auth method"
}

variable "userpass_username" {
  type        = string
  description = "Userpass username for user. Also entity alias name."
}

variable "userpass_password" {
  type        = string
  description = "Userpass password for user."
}

variable "identity_entity_name" {
  type        = string
  description = "Name of identity entity."
}

variable "identity_entity_policies" {
  type        = list
  description = "List of additional ACL policies to attach to the identity entity"
  default     = []
}
