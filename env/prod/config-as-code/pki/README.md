# Apply this terraform command first to generate the csr for the intermediate CA
```terraform apply -target=vault_mount.pki_p1_int -target=vault_pki_secret_backend_intermediate_cert_request.pki_p1_int```

# Export the csr and sign with offline root CA

# Import signed cert with root CA pub cert appended
