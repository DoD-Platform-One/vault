variable "vault_signed_CA" {
  description = "turnary operator to pause / skip unnecessary functions for int CA which will be signed by offline root CA"
  type        = bool
  default     = true
}

variable "signed_cert" {
  description = "turnary operator to skip vault sign functions for int CA which will be signed by offline root CA"
  type        = bool
  default     = true
}

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

variable "ca_csr_cn" {
  description = "(Required) CN of intermediate sub ca to create"
  type        = string
  default     = ""
}

variable "int_mount_path" {
  description = "(Required) The PKI secret backend that will sign the csr"
  type        = string
  default     = ""
}

variable "expiry" {
  description = "(Optional) Specifies the time until expiration"
  type        = string
  default     = "72h"
}

variable "disable_crl" {
  description = "(Optional) Disables or enables CRL building"
  type        = bool
  default     = false
}

variable "crl_url" {
  description = "(Optional) Specifies the URL values for the CRL Distribution Points field"
  type        = list(any)
  default     = [""]
}

variable "ocsp_svrs" {
  description = "(Optional) Specifies the URL values for the Issuing Certificate field"
  type        = list(any)
  default     = [""]
}

variable "name" {
  description = "(Required) The name to identify this role within the backend. Must be unique within the backend"
  type        = string
  default     = ""
}

variable "allowed_domains" {
  description = "(Optional) List of allowed domains for certificates"
  type        = list(any)
  default     = [""]
}

variable "allow_subdomains" {
  description = "(Optional) Flag to allow certificates matching subdomains"
  type        = bool
  default     = true
}

variable "enforce_hostnames" {
  description = "(Optional) Flag to allow only valid host names"
  type        = bool
  default     = true
}

variable "allow_any_name" {
  description = "(Optional) Flag to allow any name"
  type        = bool
  default     = false
}

variable "server_flag" {
  description = "(Optional) Flag to specify certificates for server use"
  type        = bool
  default     = true
}

variable "client_flag" {
  description = "(Optional) Flag to specify certificates for client use"
  type        = bool
  default     = true
}

variable "max_ttl" {
  description = "(Optional) The maximum TTL"
  type        = number
}

variable "ttl" {
  description = "(Optional) The TTL"
  type        = number

}

variable "key_usage" {
  description = "(Optional) Specify the allowed key usage constraint on issued certificates"
  type        = list(any)
  default     = [""]
}

variable "ext_key_usage" {
  description = "(Optional) Specify the allowed extended key usage constraint on issued certificates"
  type        = list(any)
  default     = [""]
}

variable "signed_cert_and_ca_chain" {
  description = "(Required) The signed certificate and appended ca chain in pem format"
  type        = string
  default     = ""
}

variable "ca_chain" {
  description = "(Required) List of signed certificates in CA chain"
  type        = string
  default     = ""
}
