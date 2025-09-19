# Injecting Secrets into Kubernetes Pods via Vault Agent Containers

The BigBang vault package supports the Vault's agent injector service to bind vault secrets to running pods.

For a detailed description and walk-through, see [Injecting Secrets into Kubernetes Pods via Vault Agent Containers](https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-sidecar?in=vault%2Fkubernetes)

There are 3 main parts to getting secrets to Kubernetes pods:

1. [Vault Server Configuration](#vault-server-configuration)

2. [Creating A Vault KV Secret](#creating-a-vault-kv-secret)

3. [Configure A Deployment For Injection](#configure-a-deployment-for-injection)


## Vault Server Configuration

When autoInit is enabled, the Vault helm chart will enable the Kubernetes integration after the server is initialized. To get the root token for the vault deployment if using the BigBang developer `autoInit` job:

  ```console
  kubectl get secret -n vault vault-token -o go-template='{{.data.key | base64decode}}'
  ```

The command that configure Kubernetes:

```shell
vault auth enable kubernetes

vault write auth/kubernetes/config \
  kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
  token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
  kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
  issuer="https://kubernetes.default.svc.cluster.local" 
```


## Creating A Vault KV Secret

You can create a vault secret using Vault's web interface, the **vault ** command line interface, or the Vault API.


### Creating a Vault Keystore And Secret In The BigBang Vault Server POD

This shows creating a vault secret using the **vault** command line interface which can be found in a running bigbang installation

In order to talk to the vault server. we need the admin secret which can be found with this command:

```shell
kubectl get secrets -n vault vault-token -o json | jq -r '.data["key"]' | base64 -d 
```

We'll shell into the pod and configure a secret called **testsecret** stored under **bigbang/gitlab/**.  The secret will store two encrypted keys: username and password.  We will then create a policy called **internal-app** for the secret and bind the policy to a Kubernetes service account called **internal-app** and the **mynamespace** namespace.

```shell
kubectl exec -n vault -it vault-vault-0 -- /bin/sh

#inside the running pod
export VAULT_TOKEN=<SECRET_TOKEN>
vault secrets enable -path=bigbang kv-v2
vault kv put bigbang/gitlab/testsecret username="bbuser1" password="password1"
vault kv get bigbang/gitlab/testsecret

# create a policy for a secret
vault policy write internal-app - <<EOF
path "bigbang/data/gitlab/testsecret" {
  capabilities = ["read"]
}
EOF

# bind the policy to a k8s service account and namespace
vault write auth/kubernetes/role/internal-app \
    bound_service_account_names=internal-app \
    bound_service_account_namespaces=mynamespace \
    policies=internal-app \
    ttl=24h
```

You should see the following messages as you run the commands:

```shell
...
Success! Uploaded policy: internal-app
...
Success! Data written to: auth/kubernetes/role/internal-app

```

## Configure A Deployment For Injection

For the injection to work, we'll create the internal-app service account we mapped earlier.  

For this example, you will also need a secret to pull the example image from ironbank:

```shell
kubectl create ns mynamespace
kubectl -n mynamespace create sa internal-app
kubectl apply -n mynamespace -f <some_path>/private-registry-secret.yaml
```

We need to add the following annotations and service account to our deployment definition:

```yaml
...
 annotations:
   vault.hashicorp.com/agent-inject: 'true'
   vault.hashicorp.com/role: 'internal-app'
   vault.hashicorp.com/agent-inject-secret-testsecret: 'bigbang/gitlab/testsecret'
...
    spec:
      serviceAccountName: internal-app
```

A complete deployment (this will also require the imagePullSecrets named private-registry installed to the namespace :

The **vault-ingress: true** label is required

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mshell
  labels:
    app: mshell
spec:
  selector:
    matchLabels:
      app: mshell
  template:
    metadata:
      labels:
        app: mshell
        vault-ingress: "true"
      annotations:
        vault.hashicorp.com/agent-inject: 'true'
        vault.hashicorp.com/agent-init-first: 'true'
        vault.hashicorp.com/role: 'internal-app'
        vault.hashicorp.com/agent-inject-secret-testsecret: 'bigbang/data/gitlab/testsecret'
    spec:
      serviceAccountName: internal-app
      imagePullSecrets:
        - name: private-registry
      containers:
      - name: mshell
        image: registry1.dso.mil/ironbank/redhat/ubi/ubi8-minimal:8.4
        imagePullPolicy: IfNotPresent
        command: ["bash"]
        args: ["-c", "sleep 3600"]
```

Saving the full deployment above to /tmp/y.yaml, we can install it:

```shell
kubectl apply -n mynamespace -f /tmp/t.yaml 
```

We should see the pod was deployed with additional vault-agent containers

To test that the secret was injected, shell into the mshell pod and run

```shell
cat /vault/secrets/testsecret 
```

which produces:

```shell
data: map[password:password1 username:bbuser1]
metadata: map[created_time:2021-12-10T14:37:52.7041051Z deletion_time: destroyed:false version:1]
```

