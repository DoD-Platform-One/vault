output "path" {
  description = "Where the secret backend will be mounted"
  value       = vault_mount.this.path
}

output "csr" {
  description = "Output the certificate signing request for external / offline CA signing"
  value       = vault_pki_secret_backend_intermediate_cert_request.this.csr
}

output "signed_cert" {
  description = "Output the signed certificate"
  value       = var.vault_signed_CA ? "${vault_pki_secret_backend_root_sign_intermediate.this[0].certificate}\n${var.ca_chain}" : var.signed_cert_and_ca_chain
}

output "crl_id" {
  description = "(Required) The path the PKI secret backend is mounted at, with no leading or trailing /s"
  value       = var.signed_cert ? vault_pki_secret_backend_crl_config.this[0].id : ""
}

output "crl_endpoint" {
  description = "Specifies the URL values for the CRL Distribution Points field"
  value       = var.signed_cert ? vault_pki_secret_backend_config_urls.this[0].crl_distribution_points : [""]
}
