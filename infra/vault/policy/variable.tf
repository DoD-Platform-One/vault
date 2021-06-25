variable "name" {
  description = "(Required) The name of the policy"
  type        = string
  default     = ""
}

variable "policy" {
  description = "(Required) String containing a Vault policy"
  type        = string
  default     = ""
}
