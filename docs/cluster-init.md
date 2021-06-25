
kubectl port-forward vault-0 8200:8200

VAULT_ADDR="https://127.0.0.1:8200

vault operator init \
  -recovery-shares=3 \
  -recovery-threshold=2 \
  -recovery-pgp-keys="vault-admin-1.asc,vault-admin-2.asc,vault-admin-3.asc"

# public gpg keys in ./env/stg/config-as-code/vault-init
