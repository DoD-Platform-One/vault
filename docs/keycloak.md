Vault Keycloak integration.
Vault keycloak integration is of 2 parts, the first part in keycloak and the second part in vault.
The following documents were followed for vault keycloak integration
https://learn.hashicorp.com/vault/identity-access-management/oidc-auth
https://www.keycloak.org/docs-api/11.0/rest-api/index.html
https://www.keycloak.org/docs/latest/server_admin/index.html#user-management
KeyCloak Configuration


Create a realm/client with the redirect uris
https://{host:port}/ui/vault/auth/{path}/oidc/callback
http://localhost:8250/oidc/callback


Get the client id and secret id


Vault configuration for keycloak
Execute all the steps from the documentation for API calls.
https://learn.hashicorp.com/vault/identity-access-management/oidc-auth

Create desired policy. Current policy has the capability to create, read, update, delete and list secrets in vault.
Attach the policy to a role (named manager)
Enable OIDC auth method in vault
Configure OIDC method giving values for oidc_discovery_url, oid_client_id, oidc_client_secret and default_role
Attach the role created from step 2 as default role for keycloak login.

All the steps can be executed using a script name vaultkeycloak.sh under keycloak folder.

./docs/vaultkeycloak.sh