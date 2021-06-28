variable "type" {
  description = "(Required) The name of the auth method type"
  type        = string
  default     = ""
}

variable "max_lease_ttl" {
  description = "Optional) Specifies the maximum time-to-live. If set, this overrides the global default. Must be a valid duration string"
  type        = string
  default     = ""
}

variable "default_lease_ttl" {
  description = "Optional) Specifies the maximum time-to-live. If set, this overrides the global default. Must be a valid duration string"
  type        = string
  default     = ""
}

variable "listing_visibility" {
  description = "(Optional) Specifies whether to show this mount in the UI-specific listing endpoint. Valid values are unauth or hidden"
  type        = string
  default     = "unauth"
}

variable "identity_entity_name" {
  description = "(Required) Name of the identity entity to create"
  type        = string
}

variable "identity_entity_policies" {
  description = "(Optional) A list of policies to apply to the entity"
  type        = list(any)
  default     = []
}

# variable identity_entity_metadata {
#     description = "(Optional) A Map of additional metadata to associate with the user"
#     type        = string
# }

variable "userpass_username" {
  description = "(Required) Name of the alias. Name should be the identifier of the client in the authentication source"
  type        = string
}

variable "auth_backend" {
  description = "(Required) Accessor of the mount to which the alias should belong to"
  type        = string
  default     = "vault_auth_backend.this.accessor"
}
