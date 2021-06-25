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