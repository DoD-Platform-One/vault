variable "mount_path" {
  description = "Where the secret backend will be mounted"
  type        = string
  default     = ""
}

variable "mount_type" {
  description = "Type of the backend, such as 'aws', 'pki', 'kv', etc."
  type        = string
  default     = ""
}

variable "description" {
  description = "(Optional) Human-friendly description of the mount"
  type        = string
  default     = ""
}

variable "max_mount_ttl" {
  description = "(Optional) Maximum possible lease duration for tokens and secrets in seconds"
  type        = number
}

variable "default_mount_ttl" {
  description = "(Optional) Default lease duration for tokens and secrets in seconds"
  type        = number
}

variable "seal_wrap" {
  description = "(Optional) Boolean flag that can be explicitly set to true to enable seal wrapping for the mount, causing values stored by the mount to be wrapped by the seal's encryption capability"
  type        = bool
  default     = true
}

variable "external_entropy" {
  description = "(Optional) Boolean flag that can be explicitly set to true to enable the secrets engine to access Vault's external entropy source"
  default     = true
  type        = bool
}
