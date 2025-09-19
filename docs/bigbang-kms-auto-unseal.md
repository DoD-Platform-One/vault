# BigBang KMS Auto Unseal

When installed in an AWS environment, Vault can be configured to use Amazon's KMS to unseal the server.

Vault needs the following permissions on the KMS key:

* kms:Encrypt
* kms:Decrypt
* kms:DescribeKey

See [awskms Seal](https://developer.hashicorp.com/vault/docs/configuration/seal/awskms) for additional details.

Because Vault encrypts all persistent data, the server needs keys to decrypt the data.  This process of Vault starting up, and getting the keys to decrypt the data is part of the unseal process.

This process may require several keys to be entered to unseal the data and possible human intervention.  

To simplify things in AWS, vault support using a single KMS key to auto-unseal the data on pod/server restarts.

In a production environment, it is recommended to setup a Private Endpoint for your AWS services like KMS or S3. Please review [this guide from AWS](https://docs.aws.amazon.com/kms/latest/developerguide/kms-vpc-endpoint.html) to setup routing to AWS services that never leave the AWS network.

Once created update `networkPolicies.vpcCidr` to match the CIDR of your VPC so Vault will be able to reach your VPCs DNS and new KMS endpoint.

Next, to add in auto unseal, we need to create a KMS key and pass the information to the vault server.

The autoInit chart value needs to be enabled (defaults to enabled) .  

The helm charts defined configurations for Vault depending on the modes.  In this example, the default/standalone config is replaces with a custom configuration to pass in the awskms key:


```yaml
addons:
  vault:
    enabled: true
    values:
      server:
        standalone:
          config: |
            ui = true
      
            listener "tcp" {
              tls_disable = 1
              address = "[::]:8200"
              cluster_address = "[::]:8201"
            }
      
            storage "file" {
              path = "/vault/data"
            }
      
            seal "awskms" {
              region     = "us-gov-west-1"
              kms_key_id = "a0a41a60-bca1-4024-8ec9-f2935f881afd"
            }
```

If using Vault with an Enterprise license, we can also enable Entropy Augmentation:

```yaml
seal "pkcs11" {
    ...
}

entropy "seal" {
    mode = "augmentation"
}
```

See [Entropy Augmentation Seal](https://developer.hashicorp.com/vault/docs/configuration/entropy-augmentation) for details.

With this configuration, the initial init procedure remains the same, and vault will be configured with 5 shamir keys.  See init.sh defined in [configmap-for-vault-init.yaml](../chart/templates/bigbang/autoUnsealAndInit/configmap-for-vault-init.yaml).  In addition, vault will configure the server to be unsealed with the kms_key_id key.

The vault server should start up and initialize.  

Note: it's normal to see messages like these in the vault server logs :

```shell
2021-12-09T21:20:46.897Z [INFO]  core: stored unseal keys supported, attempting fetch
2021-12-09T21:20:46.897Z [WARN]  failed to unseal core: error="stored unseal keys are supported, but none were found"
```

If the vault-vault-0 pod is kill/re-started, it should come back up and auto-seal.  A message like this will appear in the logs showing the kms unseal was successful:

```shell
│ ==> Vault server configuration:                                                                                                                            │
│              Api Address: http://10.42.1.8:8200                                                                                                            │
│                      Cgo: disabled                                                                                                                         │
│          Cluster Address: https://vault-vault-0.vault-vault-internal:8201                                                                                  │
│               Go Version: go1.16.7                                                                                                                         │
│               Listener 1: tcp (addr: "[::]:8200", cluster address: "[::]:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disable │
│                Log Level: info                                                                                                                             │
│                    Mlock: supported: true, enabled: false                                                                                                  │
│            Recovery Mode: false                                                                                                                            │
│                  Storage: file                                                                                                                             │
│                  Version: Vault v1.8.3                                                                                                                     │
│              Version Sha: 73e85c3c21dfd1e835ded0053f08e3bd73a24ad6                                                                                         │
│ ==> Vault server started! Log data will stream in below:                                                                                                   │
│ 2021-12-10T16:04:17.585Z [INFO]  proxy environment: http_proxy="" https_proxy="" no_proxy=""                                                               │
│ 2021-12-10T16:04:20.861Z [INFO]  core: stored unseal keys supported, attempting fetch                                                                      │
│ 2021-12-10T16:04:20.888Z [INFO]  core.cluster-listener.tcp: starting listener: listener_address=[::]:8201                                                  │
│ 2021-12-10T16:04:20.888Z [INFO]  core.cluster-listener: serving cluster requests: cluster_listen_address=[::]:8201                                         │
│ 2021-12-10T16:04:20.888Z [INFO]  core: post-unseal setup starting                                                                                          │
│ 2021-12-10T16:04:20.889Z [INFO]  core: loaded wrapping token key                                                                                           │
│ 2021-12-10T16:04:20.889Z [INFO]  core: successfully setup plugin catalog: plugin-directory=""                                                              │
│ 2021-12-10T16:04:20.890Z [INFO]  core: successfully mounted backend: type=system path=sys/                                                                 │
│ 2021-12-10T16:04:20.891Z [INFO]  core: successfully mounted backend: type=identity path=identity/                                                          │
│ 2021-12-10T16:04:20.891Z [INFO]  core: successfully mounted backend: type=cubbyhole path=cubbyhole/                                                        │
│ 2021-12-10T16:04:20.894Z [INFO]  core: successfully enabled credential backend: type=token path=token/                                                     │
│ 2021-12-10T16:04:20.895Z [INFO]  core: successfully enabled credential backend: type=kubernetes path=kubernetes/                                           │
│ 2021-12-10T16:04:20.895Z [INFO]  rollback: starting rollback manager                                                                                       │
│ 2021-12-10T16:04:20.896Z [INFO]  core: restoring leases                                                                                                    │
│ 2021-12-10T16:04:20.897Z [INFO]  expiration: lease restore complete                                                                                        │
│ 2021-12-10T16:04:20.897Z [INFO]  identity: entities restored                                                                                               │
│ 2021-12-10T16:04:20.897Z [INFO]  identity: groups restored                                                                                                 │
│ 2021-12-10T16:04:20.923Z [INFO]  core: usage gauge collection is disabled                                                                                  │
│ 2021-12-10T16:04:20.923Z [INFO]  core: post-unseal setup complete                                                                                          │
│ 2021-12-10T16:04:20.923Z [INFO]  core: vault is unsealed                                                                                                   │
│ 2021-12-10T16:04:20.923Z [INFO]  core: unsealed with stored key  
```
