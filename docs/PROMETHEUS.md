# Vault With Prometheus

## Overview

[[_TOC_]]

This guide creates a Role called **prometheus-monitoring** and binds the Role to the **monitoring-monitoring-kube-prometheus** service account in the **monitoring** namespace

## Prerequisites

### Vault Initialization & Kubernetes Authentication Method

The Kubernetes Authentication Method can be enabled/configured using Vault's web interface or by the vault cli.

See [HashiCorp Vault Kubernetes Auth Method](https://developer.hashicorp.com/vault/docs/auth/kubernetes) for more details

* Exec into a vault pod & login via the CLI (see below) and run the following commands:

  ```shell
  vault operator init

  vault auth enable kubernetes
  
  vault write auth/kubernetes/config \
    kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
    issuer="https://kubernetes.default.svc.cluster.local" 
  ```

* To get the root token for the vault deployment if using the BigBang developer `autoInit` job:

  ```shell
  kubectl get secret -n vault vault-token -o go-template='{{.data.key | base64decode}}'
  ```

For each of these steps we will be running commands against vault from the CLI so you should be exec'd in and logged in like so:

```shell
kubectl exec -it pod/vault-vault-0 -n vault -- /bin/bash

vault login
<WILL ASK FOR AUTHENTICATION, PASTE IN YOUR ROOT TOKEN>
```

## Vault ACL Policy for Metrics

Vault exposes Prometheus metrics at the **/sys/metrics** url.

Since Prometheus needs read ability, we create the policy via the CLI by exec-ing into a vault pod:

```shell
vault policy write prometheus-monitoring - << EOF
    path "/sys/metrics" {
      capabilities = ["read"]
    }
EOF
```

Then attach the policy to the existing `monitoring-monitoring-kube-prometheus` ServiceAccount used by the Prometheus pod:

```shell
vault write auth/kubernetes/role/prometheus \
      bound_service_account_names=monitoring-monitoring-kube-prometheus \
      bound_service_account_namespaces=monitoring \
      policies="default,prometheus-monitoring" \
      ttl="15m"
```

## Prometheus Configuration
### Vault Sidecar Injection

Using a k8s MutatingWebhookConfiguration (vault-vault-agent-injector-cfg), Vault will add a sidecar to annotated pods.

See [HashiCorp Vault Agent Annotations](https://developer.hashicorp.com/vault/docs/platform/k8s/injector/annotations#agent-annotations) for details

The Big Bang prometheus pod is annotated with the following values when both `monitoring` & `vault` are enabled within BigBang:

```yaml
vault.hashicorp.com/agent-inject: "true"
vault.hashicorp.com/agent-init-first: "true"
vault.hashicorp.com/agent-inject-token: "true"
vault.hashicorp.com/role: "prometheus"
```

With these settings, the Vault sidecar will mount the Vault token assigned to the kubernetes/prometheus role inside the pod at **/vault/secrets/token** .

Mounting the token inside the pod allows the Prometheus configuration to pass the token when it scrapes data from Vault.

### Metrics Endpoint Configuration

Prometheus is configured using an `additionalScrapeConfig` passthrough value to scrape the metrics from Vault.  We define the endpoint and location of the token file to use for authentication.

(see https://repo1.dso.mil/platform-one/big-bang/bigbang/-/merge_requests/2106/diffs)

```yaml
  additionalScrapeConfigs:
    - job_name: vault
      metrics_path: /v1/sys/metrics
      params:
        format: ['prometheus']
      scheme: https
      authorization:
        credentials_file: /vault/secrets/token
      static_configs:
      - targets: [vault.dev.bigbang.mil]
```

## Known issues

**These only apply to development and testing environments which are using the Big Bang default settings**

### Permission denied trying to re-authenticate after upgrade
After upgrading Big Bang versions you may encounter an issue where the Prometheus pod is unable to start. Tailing the logs should reveal an error that looks like this coming from the `vault-agent-init` initContianer:
```plaintext
vault-agent-init 2024-12-03T20:55:20.244Z [ERROR] agent.auth.handler: error authenticating:
  error=Error making API request.
  URL: PUT https://vault.example.com/v1/auth/kubernetes/login
  Code: 403. Errors:
    * permission denied
```
To resolve this, you will need to re-save the **Access/Authentication Methods/kubernetes/Configuration/Configure** settings.

1. Get the Vault root token
  - If using the BigBang developer `autoInit` job, you can access the root token by running the following command:
```shell
kubectl get secret -n vault vault-token -o go-template='{{.data.key | base64decode}}'
```
2. Get a shell to the running Vault pod
```shell
kubectl exec -it pod/vault-vault-0 -n vault -- /bin/bash
```
3. Login to Vault uasing the root token
```shell
vault login
```
4.  Re-save the **Access/Authentication Methods/kubernetes/Configuration/Configure** settings
```shell
vault write auth/kubernetes/config \
  kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
  issuer="https://kubernetes.default.svc.cluster.local" 
```
5. Restart the Prometheus pod

After restarting the Prometheus pod, the vault-agent-init container should start successfully and the Prometheus pod should be able to start.

See here for possible, related issue: [after-upgrading-to-kubernetes-1-21-kubernetes-authentication-request-to-vault-fails-with-permission-denied](https://discuss.hashicorp.com/t/after-upgrading-to-kubernetes-1-21-kubernetes-authentication-request-to-vault-fails-with-permission-denied/29392)

## Vault Reference Documentation

* [HashiCorp Vault Telemetry](https://developer.hashicorp.com/vault/docs/configuration/telemetry#prometheus)
* [HashiCorp Vault Agent Annotations](https://developer.hashicorp.com/vault/docs/platform/k8s/injector/annotations#agent-annotations)
* [HashiCorp Vault Kubernetes Auth Method](https://developer.hashicorp.com/vault/docs/auth/kubernetes)
