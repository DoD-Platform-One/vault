# Vault With Prometheus

## Vault Reference Documentation

* [HashiCorp Vault Telemetry](https://www.vaultproject.io/docs/configuration/telemetry#prometheus)
* [HashiCorp Vault Agent Annotations](https://www.vaultproject.io/docs/platform/k8s/injector/annotations#agent-annotations)
* [HashiCorp Vault Kubernetes Auth Method](https://www.vaultproject.io/docs/auth/kubernetes)

## Overview

Prometheus scraping of Vault uses the following:
* [Vault Kubernetes Authentication Method](#vault-kubernetes-authentication-method)
    * The auth method is bound to a k8s service account
    * The auth method is bound to a k8s namespace
* [Vault ACL Policy Defined](#vault-acl-policy-defined)
* [Vault Sidecar Injection](#vault-sidecar-injection)
* [Prometheus Configuration](#prometheus-configuration)


Known issues:
* [Big Bang Development Environment Upgrade Issues](#big-bang-development-environment-upgrade-issues)

## Vault Kubernetes Authentication Method

The Kubernetes Authentcation Method can be create using Vault's web interface or by the vault cli.

See [HashiCorp Vault Kubernetes Auth Method](https://www.vaultproject.io/docs/auth/kubernetes) for more details

An example for Big Bang can be found in the initialization script [configmap-for-vault-init.yaml](../chart/templates/bigbang/autoUnsealAndInit/configmap-for-vault-init.yaml) .

This script creates an Auth Method called **prometheus** and binds the Auth Method to the **monitoring-monitoring-kube-prometheus** service account and **monitoring** namespace


## Vault ACL Policy Defined

Vault exposes Prometheus metrics at the **/sys/metrics** url. 

Since Prometheus needs read ability, we create the policy with this:

```yaml
    path "/sys/metrics" { 
     capabilities = ["read"]
    }
```

## Vault Sidecar Injection

Using a k8s MutatingWebhookConfiguration (vault-vault-agent-injector-cfg), Vault will add a sidecar to annotated pods.

See [HashiCorp Vault Agent Annotations](https://www.vaultproject.io/docs/platform/k8s/injector/annotations#agent-annotations) for details

The Big Bang prometheus pod is annotated with the following valules:

```yaml
vault.hashicorp.com/agent-inject: "true"
vault.hashicorp.com/agent-init-first: "true"
vault.hashicorp.com/agent-inject-token: "true"      
vault.hashicorp.com/role: "prometheus"
```

With these settings, the Vault sidecar will mount the Vault token assigned to the kubernetes/prometheus role inside the pod at **/vault/secrets/token** .  

Mounting the token inside the pod allows the Prometheus configuration to pass the token when it scrapes data from Vault.

## Prometheus Configuration

Prometheus is configured using a ServiceMonitor to scrape the metrics from Vault.  We define the endpoint and location of the mounted token file to use for authentication.

(see monitoring/chart/templates/bigbang/vault-servicemonitor.yaml)

```yaml
endpoints:
- port: http
  path: /v1/sys/metrics
  bearerTokenFile: /vault/secrets/token  
  scheme: http    
  params:
    format: ['prometheus']  
```

## Big Bang Development Environment Upgrade Issues

**These only apply to development and testing environments which are using the Big Bang default settings**

1. Earlier versions set the service account name to **prometheus** -- it should be **monitoring-monitoring-kube-prometheus**
    * **Fix**: Using the Vault web interface, replace **prometheus** with **monitoring-monitoring-kube-prometheus** under the settings **kubernetes/prometheus auth Bound service account names**
2. Permission denied trying to re-authenticate after upgrade 
    * see here for possible, related issue [after-upgrading-to-kubernetes-1-21-kubernetes-authentication-request-to-vault-fails-with-permission-denied](https://discuss.hashicorp.com/t/after-upgrading-to-kubernetes-1-21-kubernetes-authentication-request-to-vault-fails-with-permission-denied/29392)
    * **Fix**: Re-save the **Access/Authentication Methods/kubernetes/Configuration/Configure** settings
