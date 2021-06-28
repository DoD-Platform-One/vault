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
  description = "(Optional) Specifies whether to show this mount in the UI-specific listing endpoint. Valid values are 'unauth' or 'hidden'"
  type        = string
  default     = "unauth"
}
