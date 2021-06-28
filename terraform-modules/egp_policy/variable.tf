variable "name" {
  description = "(Required) The name of the policy"
  type        = string
  default     = ""
}

variable "paths" {
  description = "(Required) List of paths to which the policy will be applied to"
  type        = list(any)
  default     = []
}

variable "enforcement_level" {
  description = "(Required) Enforcement level of Sentinel policy. Can be either 'advisory' or 'soft-mandatory' or 'hard-mandatory'"
  type        = string
  default     = ""
}

variable "policy" {
  description = "(Required) String containing a Sentinel policy"
  type        = string
  default     = ""
}