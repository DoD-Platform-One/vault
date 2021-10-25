#!/bin/bash
set -euo pipefail

/*  Before you execute the script, check the values for:
    keycloak endpoint
    vault endpoint
    keycloak credentials
    vault credentials
    
    Also make sure that you have jq installed. 
*/

username=
password=
vaultoken=
realmname="platformone"
APP_URL="https://keycloak.fences.dsop.io"
VAULT_URL="https://vault.fences.dsop.io"
clientId="vault"
clientName="vault"

# STEP 1: This step is to get the  bearer token keycloak api transactions
export ACCESS_TOKEN=$(curl \
-d "client_id=admin-cli" \
-d "username=$username" \
-d "password=$password" \
-d "grant_type=password" \
"$APP_URL/auth/realms/master/protocol/openid-connect/token" | jq -r '.access_token') 



# STEP 2: This step is to create a new realm in keycloak.  Execute this step, if it is required to create new realm

curl -v -X POST \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"realm": "'"$realmname"'"}' \
  $APP_URL/auth/admin/realms

  
# STEP 3: This step is to create new client for the realm created in step 2. If, differenct realm name is used, adjust your realmname variable

  curl -v -X POST \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
 -d '{ "clientId": "'"$clientId"'" ,   "redirectUris":  ["https://vault.fences.dsop.io/ui/vault/auth/oidc/oidc/callback" , "https://localhost:8250/oidc/callback"]}' \
  $APP_URL/auth/admin/realms/$realmname/clients
  
# STEP 4: Query to get the id for the client created by STEP 3

  export id=$(curl  -X GET \
   -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d "clientId=$clientId" \
   $APP_URL/auth/admin/realms/$realmname/clients?clientId=$clientId | jq -r '.[].id')

   echo $id

# STEP 5 : Get the client secret id for the client create by STEP 3

   export client_secret=$(curl  -X GET \
   -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d "clientId=$clientId" \
   $APP_URL/auth/admin/realms/$realmname/clients/$id/client-secret  | jq -r '.value')

   echo $client_secret



# STEP 6 : Vault for configuration
  # Create Policies for the vault

   tee payload-mgr.json <<EOF
   {
        "policy": "path \"/secret/*\" {\n\tcapabilities = [\"create\", \"read\", \"update\", \"delete\", \"list\"]\n}\n"
        }
      EOF

  # Post the Policy created above in Vault
  
  curl --header "X-Vault-Token: $vaultoken" --request PUT \
      --data @payload-mgr.json \
     $VAULT_URL/v1/sys/policies/acl/manager

# STEP 7 : Enable OIDC auth method is vault 

  # Enable OIDC auth Method


    curl --header "X-Vault-Token: $vaultoken" \
      --request POST \
      --data '{"type": "oidc"}' \
      $VAULT_URL/v1/sys/auth/oidc

# STEP 8: Configure the OIDC method created by STEP 7

  # Configure OIDC method
  url=$VAULT_URL/auth/realms/$realmname

  echo "the url is $url"
  echo " the is is $id"
  echo "the client secret is $client_secret"
    tee oidc_config.json <<EOF
     {
       "oidc_discovery_url": "$APP_URL/auth/realms/$realmname",
       "oidc_client_id": "vault" ,
       "oidc_client_secret": "$client_secret",
       "default_role": "manager"
      }
   EOF

    curl --header "X-Vault-Token: $vaultoken" \
      --request POST \
      --data @oidc_config.json \
      $VAULT_URL/v1/auth/oidc/config

# STEP 9 : Create a default role in vault
  # Create the manager role as the default_role 

    tee oidc_role.json <<EOF
       {  
          "bound_audiences": "$clientId",
          "allowed_redirect_uris": [
          "$VAULT_URL/ui/vault/auth/oidc/oidc/callback",
          "http://localhost:8250/oidc/callback"
          ],
         "user_claim": "sub",
         "policies": ["manager"]
         }
    EOF

  # Post the role in vault
    curl --header "X-Vault-Token: $vaultoken" \
      --request POST \
      --data @oidc_role.json \
      $VAULT_URL/v1/auth/oidc/role/manager
