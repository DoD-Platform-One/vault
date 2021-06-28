variable "path" {
  description = "(Required) The full logical path at which to write the given data. Consult each backend's documentation to see which endpoints support the PUT methods and to determine whether they also support DELETE and GET."
  type        = string
  default     = ""
}

variable "data_json" {
  description = "(Required) String containing a JSON-encoded object that will be written to the given path as the secret data."
  type        = string
  default     = ""
}

variable "ignore_absent_fields" {
  description = "(Optional) True/false. If set to true, ignore any fields present when the endpoint is read but that were not in data_json"
  type        = bool
  default     = true
}

variable "write_fields" {
  description = " (Optional) A list of fields that should be returned in write_data_json and write_data. If omitted, data returned by the write operation is not available to the resource or included in state. This helps to avoid accidental storage of sensitive values in state. Some endpoints, such as many dynamic secrets endpoints, return data from writing to an endpoint rather than reading it. You should use write_fields if you need information returned in this way."
  type        = string
  default     = ""
}
