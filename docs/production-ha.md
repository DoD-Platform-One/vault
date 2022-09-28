# Vault configuration for production high availability
This document describes BigBang recommended minimum production/operational settings. Vault is a large complicated application and has many options that cannot adequately be covered here. Vault has significant security risks if not properly configured and administrated. Please consult the upstream [Vault documentation](https://learn.hashicorp.com/tutorials/vault/kubernetes-raft-deployment-guide?in=vault/kubernetes#configure-vault-helm-chart) as the ultimate authority.

## Vault Initialization
Regardless of whether or not you configure for auto-unseal, you must first initialize Vault for a new deployment. Exec into one of the Vault k8s containers.
```bash
kubectl exec -it pod/vault-vault-0 -n vault /bin/bash
```
From there you can initialize the deployment. See the [Vault documentation](https://www.vaultproject.io/docs/commands/operator/init)

## Disable Auto Init
BigBang developed an ```autoInit``` k8s job that initializes and unseals Vault and writes the root token and unseal keys to a k8s secret. This should only be used for development, CI pipelines, or demos. The root token and unlock keys should not be discoverable from a k8s secret. This setting should be disabled for operational deployments.
```yaml
autoInit:
  enabled: false
```

## High availability
An operational deployment of Vault should be configured for high availability.
```yaml
server:
  ha:
    enabled: true
    replicas: 3
```

## Auto Unseal
For an operational deployment of Vault you should use [Auto Unseal](https://learn.hashicorp.com/collections/vault/auto-unseal). Automatically unsealing Vault reduces the operational maintenance of having to manually unseal when a k8s pod restarts. You must setup AWS IAM role and policy. See the [example policy](./awsKMSPolicy.md).
```yaml
server:
  ha:
    raft:
      enabled: true
      config: |
        seal "awskms" {
          region     = "us-gov-west-1"
          kms_key_id = "your-kms-id"
          endpoint   = "https://kms.us-gov-west-1.amazonaws.com"
        }
```

## Production/Operational Configuration Example
The following is a bare minimum configuration for a production/operational deployment. We recommend high availability and auto-unseal. Assumptions and considerations:
1. This example assumes AWS is the cloud provider. [Documentation for other cloud providers](https://learn.hashicorp.com/tutorials/vault/kubernetes-raft-deployment-guide?in=vault/kubernetes#vault-storage-config) is provided by Vault.
1. This example config uses passthrough ingress. It is possible to deploy Vault with TLS termination at the ingress gateway. But for better security TLS should be passed through to the Vault backend by using passthrough ingress. Also, passthrough ingress is required for Vault site-to-site replication. When deploying this Package with BigBang you should configure an istio passthrough gateway in the BigBang chart values and provide the passthrough cert. If the key and cert values are provided the vault-tls secret will be created for you and also take care of the secret volume and volume mount. Otherwise you can create the secret and config for volume/volumemount yourself.
    ```yaml
    istio:
      enabled: true

      ingressGateways:

        passthrough-ingressgateway:
          type: "LoadBalancer"
          # nodePortBase: 30200

      gateways:
        passthrough:
          ingressGateway: "passthrough-ingressgateway"
          hosts:
          - "*.{{ .Values.domain }}"
          tls:
            mode: "PASSTHROUGH"

    addons:
      vault:
        ingress:
          gateway: "passthrough"
          key: |
            -----BEGIN PRIVATE KEY-----
            xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            -----END PRIVATE KEY-----
          cert: |
            -----BEGIN CERTIFICATE-----
            xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            -----END CERTIFICATE-----
    ```
1. Your cluster CSI storage should be configured with Reclaim Policy set as "Retain", otherwise you will loose data.
1. S3 storage is a valid configuration but BigBang does not provide documentation because S3 is not cloud agnostic and is not compatible with many air-gap environments.
1. The internal server name when deployed with BigBang chart is ```vault-vault-X.vault-vault-internal```. If you deploy separately from BigBang then the internal server name is ```vault-X.vault-internal```
    ```yaml

    # disable autoInit. It should not be used for operations.
    autoInit:
      enabled: false

    global:
      # this is a double negative. Put "false" to enable TLS
      tlsDisable: false

    server:
      # The BigBang helm chart has configuration that can create the vault-tls secret and volumemount for you
      # Volume mount the secret so that Vault can support Istio ingress passthrough
      volumes:
      - name: tls
        secret:
          secretName: vault-tls
      volumeMounts:
      - name: tls
        mountPath: "/vault/tls"
        readOnly: true
      dataStorage:
        enabled: true
        size: 50Gi
        mountPath: "/vault/data"
        accessMode: ReadWriteOnce

      # Increase default resources
      resources:
        requests:
          memory: 8Gi
          cpu: 2000m
        limits:
          memory: 8Gi
          cpu: 2000m

      # disable the Vault provided ingress so that Istio ingress can be used.
      ingress:
        enabled: false

      # Extra environment variable to support high availability
      extraEnvironmentVars:
        VAULT_SKIP_VERIFY: "true"
        VAULT_LOG_FORMAT: "json"
        VAULT_LICENSE: "your-license-key-goes-here"

      ha:
        # enable high availability.
        enabled: true
        replicas: 3

	# tell the deployments where our Vault API endpoint is
	# see https://github.com/hashicorp/vault-helm/issues/789
        apiAddr: "https://vault.bigbang.dev"

        # raft is the license free most simple solution for distributed filesystem
        raft:
          enabled: true
          setNodeId: true

          # This config should be encrypted to prevent the kms_key_id from being revealed
          config: |
            ui = true

            listener "tcp" {
              tls_disable = false
              address = "[::]:8200"
              cluster_address = "[::]:8201"
              tls_cert_file = "/vault/tls/tls.crt"
              tls_key_file  = "/vault/tls/tls.key"
              telemetry {
                unauthenticated_metrics_access = true
              }
            }

            storage "raft" {
              path = "/vault/data"

              retry_join {
                leader_api_addr = "https://vault-vault-0.vault-vault-internal:8200"
                leader_client_cert_file = "/vault/tls/tls.crt"
                leader_client_key_file = "/vault/tls/tls.key"
                leader_tls_servername = "vault.bigbang.dev"
              }

              retry_join {
                leader_api_addr = "https://vault-vault-1.vault-vault-internal:8200"
                leader_client_cert_file = "/vault/tls/tls.crt"
                leader_client_key_file = "/vault/tls/tls.key"
                leader_tls_servername = "vault.bigbang.dev"
              }

              retry_join {
                leader_api_addr = "https://vault-vault-2.vault-vault-internal:8200"
                leader_client_cert_file = "/vault/tls/tls.crt"
                leader_client_key_file = "/vault/tls/tls.key"
                leader_tls_servername = "vault.bigbang.dev"
              }
            }

            seal "awskms" {
              region     = "us-gov-west-1"
              kms_key_id = "your-kms-key-goes-here"
              endpoint   = "https://kms.us-gov-west-1.amazonaws.com"
            }

            telemetry {
              prometheus_retention_time = "24h"
              disable_hostname = true
            }

            service_registration "kubernetes" {}
    ```
