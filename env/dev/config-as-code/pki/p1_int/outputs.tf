output "pki_p1_csr" {
  value = vault_pki_secret_backend_intermediate_cert_request.pki_p1_int.csr
}

 output "vault_mount" {
     value = vault_mount.pki_p1_int.path
 }