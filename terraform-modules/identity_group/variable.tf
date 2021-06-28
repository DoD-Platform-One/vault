variable "name" {
  description = "(Required, Forces new resource) Name of the identity group to create"
  type        = string
  default     = ""
}

variable "policies" {
  description = "(Optional) A list of policies to apply to the group"
  type        = list(any)
  default     = ["default"]
}

variable "member_entity_ids" {
  description = "(Optional) A list of Entity IDs to be assigned as group members. Not allowed on external groups"
  type        = list(any)
  default     = [""]
}

# variable identity_entity_metadata {
#     description = "(Optional) A Map of additional metadata to associate with the user"
#     type        = string
# }
