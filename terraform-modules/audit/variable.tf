variable "type" {
  description = "(Required) Type of the audit device, such as 'file'."
  type        = string
}

variable "path" {
  description = "(Optional) Human-friendly description of the audit device."
  type        = string
}

variable "description" {
  description = "(Optional) Boolean flag that can be explicitly set to true to enable seal wrapping for the mount, causing values stored by the mount to be wrapped by the seal's encryption capability"
  type        = string
}


variable "local" {
  description = "(Optional) Human-friendly description of the mount"
  type        = bool
}

variable "options" {
  description = "(Optional) Maximum possible lease duration for tokens and secrets in seconds"
  type        = map(any)
}
