variable "userpass_mount_accessor" {
  type        = string
  description = "Mount accessor for userpass auth method"
}

variable "userpass_username" {
  type        = string
  description = "Userpass username for user. Also entity alias name."
}

variable "identity_entity_name" {
  type        = string
  description = "Name of identity entity."
}
