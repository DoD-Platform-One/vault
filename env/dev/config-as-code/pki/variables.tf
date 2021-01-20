# TODO: Move to PKI

variable "enable_seal_wrap" {
  type        = bool
  description = "Boolean to enable seal wrapping on secrets engines. Requires HSM."
}

variable "enable_external_entropy_access" {
  type        = bool
  description = "Boolean to enable external entropy on secrets engines. Requires HSM."
}
