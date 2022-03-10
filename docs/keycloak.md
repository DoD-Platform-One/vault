# Vault Keycloak integration.
Because of security concerns BigBang does not provide automated SSO integration with Vault. Also, there is not a one-size-fits-all for all organizations. Each organization must determine their own Vault policies. Instead, BigBang provides example steps that operational environments can follow and modify. The example assumes that the domain is ```*.bigbang.dev```.

Vault SSO integration requires configuration in Keycloak and configuration in Vault.

Reference online documentation:
https://learn.hashicorp.com/vault/identity-access-management/oidc-auth
https://www.spicyomelet.com/sso-with-keycloak-and-hashicorp-vault/

## KeyCloak Configuration
There is a sample Keycloak realm with pre-configured clients in the [Keycloak package repository](https://repo1.dso.mil/platform-one/big-bang/apps/security-tools/keycloak/-/tree/main/chart/resources/dev/).
Create an OIDC client with the following (modify as needed):
1. Client ID:  dev_00eb8904-5b88-4c68-ad67-cec0d2e07aa6_vault
1. Clinet Protocol:  openid-connect
1. Name:  Dev Vault
1. Access Type:  confidential  (or ```public``` for dev environments)
1. Valid Redirect URIs:
    https://vault.bigbang.dev/ui/vault/auth/oidc/oidc/callback
    http://vault.bigbang.dev/oidc/callback
1. Click ```Save``` button
1. Map ```groups``` to user token claim. This will create a field on the user token that includes the user's Keycloak groups. This is needed so that Vault can use Keycloak groups.  
    a. Click the Mappers tab  
    b. Click the Create button  
    c. Name: groups  
    d. Mapper Type: Group Membership  
    e. Token Claim Name: groups  
    f. Full group path: OFF  
    g. click save button  
1. Note the client secret on the credentials tab if the Access Type is ```confidential``` 
1. Optional: Create a ```vault-admin``` group
1. Optional: Add user(s) to the vault-admin group

## Vault configuration
The [upstream Vault documentation](https://learn.hashicorp.com/tutorials/vault/oidc-auth) provides examples of CLI command, API using cURL, or Web UI. We will use CLI commands here. For convenience, we will exec onto the Vault pod so that we don't have to install vault on our workstation.
1. Exec onto the Vault pod
    ```
    kubectl exec -n vault -it vault-vault-0 -- /bin/bash -c "cd /home/vault/ && /bin/bash"
    ```
1. Set environment variables that will be used by CLI commands. You will need the vault root token. If you enabled autoinit the root token can be found in the [vault-token secret](./login-vault.md)
    ```
    export OIDC_CLIENT_ID=dev_00eb8904-5b88-4c68-ad67-cec0d2e07aa6_vault
    export OIDC_CLIENT_SECRET=fakesecret
    export ALLOWED_REDIRECT_URI_1=https://vault.bigbang.dev/ui/vault/auth/oidc/oidc/callback
    export ALLOWED_REDIRECT_URI_2=https://vault.bigbang.dev/oidc/callback
    export OIDC_DISCOVERY_URL=https://keycloak.bigbang.dev/auth/realms/baby-yoda
    export VAULT_TOKEN=your-vault-root-token
    ```
1. create a default reader policy
    ```
    tee reader.hcl <<EOF
    # Read permission on the k/v secrets
    path "/secret/*" {
        capabilities = ["read", "list"]
    }
    EOF
    
    vault policy write reader ./reader.hcl
    ```
    view it
    ```
    vault policy list
    vault policy read reader
    ```
1. enable the OIDC auth method
    ```
    vault auth enable oidc
    ```
1. create an OIDC role with the reader policy that also has a groups claim that can map Keycloak groups to Vault. Note that there does not seem to be any way to create or view OIDC roles from the Web UI.
    ```
    vault write auth/oidc/role/reader \
      bound_audiences="$OIDC_CLIENT_ID" \
      allowed_redirect_uris="$ALLOWED_REDIRECT_URI_1" \
      allowed_redirect_uris="$ALLOWED_REDIRECT_URI_2" \
      user_claim="sub" \
      policies="reader" \
      role_type="oidc" \
      groups_claim="groups"
    ```
    view it
    ```
    vault list auth/oidc/role
    vault read -format=json auth/oidc/role/reader
    ```
1. configure the OIDC auth method
    ```
    vault write auth/oidc/config \
      oidc_discovery_url="$OIDC_DISCOVERY_URL" \
      oidc_client_id="$OIDC_CLIENT_ID" \
      oidc_client_secret="$OIDC_CLIENT_SECRET" \
      default_role=reader
    ```
1. create an admin policy
    ```
    tee admin.hcl <<EOF
    # for development or demo environments only. Allow all operations on all paths
    path "*" {
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    }
    EOF

    vault policy write admin ./admin.hcl
    ```
1. create an admin group
    ```
    vault write identity/group \
      name=admin \
      type=external \
      policies=admin
    ```
1. set environment variable with the admin group id
    ```
    export ADMIN_GROUP_ID=$(vault read -field=id identity/group/name/admin)
    ```
1. get OIDC accessor id
    ```
    # ideally the id could be retrieved directly but the jq command is not available in the Vault container
    export OIDC_AUTH_ACCESSOR=$(vault auth list -format=json  | jq -r '."oidc/".accessor')
    # instead list the auth items and note the OIDC accessor value
    vault auth list
    ```
1. set environment variable with OIDC accessor id
    ```
    export OIDC_AUTH_ACCESSOR=oidc-auth-accessor-id-from-previous-step
    ```
1. create the group alias to link the Keycloak group to the Vault group. The Vault group alias name should match the Keycloak group name.
    ```
    vault write identity/group-alias \
      name=vault-admin \
      mount_accessor=$OIDC_AUTH_ACCESSOR \
      canonical_id=$ADMIN_GROUP_ID
    ```
