# vault

![Version: 0.16.1-bb.1](https://img.shields.io/badge/Version-0.16.1--bb.1-informational?style=flat-square) ![AppVersion: 1.8.3](https://img.shields.io/badge/AppVersion-1.8.3-informational?style=flat-square)

Official HashiCorp Vault Chart

## Upstream References
* <https://www.vaultproject.io>

* <https://github.com/hashicorp/vault>
* <https://github.com/hashicorp/vault-helm>
* <https://github.com/hashicorp/vault-k8s>
* <https://github.com/hashicorp/vault-csi-provider>

## Learn More
* [Application Overview](docs/overview.md)
* [Other Documentation](docs/)

## Pre-Requisites

* Kubernetes Cluster deployed
* Kubernetes config installed in `~/.kube/config`
* Helm installed

Kubernetes: `>= 1.14.0-0`

Install Helm

https://helm.sh/docs/intro/install/

## Deployment

* Clone down the repository
* cd into directory
```bash
helm install vault chart/
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.enabled | bool | `true` |  |
| global.imagePullSecrets[0] | string | `"private-registry"` |  |
| global.tlsDisable | bool | `true` |  |
| global.openshift | bool | `false` |  |
| global.psp.enable | bool | `false` |  |
| global.psp.annotations | string | `"seccomp.security.alpha.kubernetes.io/allowedProfileNames: docker/default,runtime/default\napparmor.security.beta.kubernetes.io/allowedProfileNames: runtime/default\nseccomp.security.alpha.kubernetes.io/defaultProfileName:  runtime/default\napparmor.security.beta.kubernetes.io/defaultProfileName:  runtime/default\n"` |  |
| injector.enabled | bool | `true` |  |
| injector.replicas | int | `1` |  |
| injector.port | int | `8080` |  |
| injector.leaderElector.enabled | bool | `false` |  |
| injector.leaderElector.image.repository | string | `"registry.dso.mil/platform-one/big-bang/apps/sandbox/vault/leader-elector"` |  |
| injector.leaderElector.image.tag | string | `"0.4"` |  |
| injector.leaderElector.ttl | string | `"60s"` |  |
| injector.metrics.enabled | bool | `true` |  |
| injector.externalVaultAddr | string | `""` |  |
| injector.image.repository | string | `"registry1.dso.mil/ironbank/hashicorp/vault/vault-k8s"` |  |
| injector.image.tag | string | `"0.11.0"` |  |
| injector.image.pullPolicy | string | `"IfNotPresent"` |  |
| injector.agentImage.repository | string | `"registry1.dso.mil/ironbank/hashicorp/vault/vault"` |  |
| injector.agentImage.tag | string | `"1.8.3"` |  |
| injector.agentDefaults.cpuLimit | string | `"500m"` |  |
| injector.agentDefaults.cpuRequest | string | `"500m"` |  |
| injector.agentDefaults.memLimit | string | `"250Mi"` |  |
| injector.agentDefaults.memRequest | string | `"250Mi"` |  |
| injector.agentDefaults.template | string | `"map"` |  |
| injector.agentDefaults.templateConfig.exitOnRetryFailure | bool | `true` |  |
| injector.authPath | string | `"auth/kubernetes"` |  |
| injector.logLevel | string | `"info"` |  |
| injector.logFormat | string | `"standard"` |  |
| injector.revokeOnShutdown | bool | `false` |  |
| injector.namespaceSelector | object | `{}` |  |
| injector.objectSelector | object | `{}` |  |
| injector.failurePolicy | string | `"Ignore"` |  |
| injector.webhookAnnotations | object | `{}` |  |
| injector.certs.secretName | string | `nil` |  |
| injector.certs.caBundle | string | `""` |  |
| injector.certs.certName | string | `"tls.crt"` |  |
| injector.certs.keyName | string | `"tls.key"` |  |
| injector.resources.requests.memory | string | `"256Mi"` |  |
| injector.resources.requests.cpu | string | `"250m"` |  |
| injector.resources.limits.memory | string | `"256Mi"` |  |
| injector.resources.limits.cpu | string | `"250m"` |  |
| injector.extraEnvironmentVars | object | `{}` |  |
| injector.affinity | string | `"podAntiAffinity:\n  requiredDuringSchedulingIgnoredDuringExecution:\n    - labelSelector:\n        matchLabels:\n          app.kubernetes.io/name: {{ template \"vault.name\" . }}-agent-injector\n          app.kubernetes.io/instance: \"{{ .Release.Name }}\"\n          component: webhook\n      topologyKey: kubernetes.io/hostname\n"` |  |
| injector.tolerations | list | `[]` |  |
| injector.nodeSelector | object | `{}` |  |
| injector.priorityClassName | string | `""` |  |
| injector.annotations | object | `{}` |  |
| injector.extraLabels | object | `{}` |  |
| injector.hostNetwork | bool | `false` |  |
| injector.service.annotations | object | `{}` |  |
| server.enabled | bool | `true` |  |
| server.extraSecretEnvironmentVars[0].envName | string | `"AWS_ACCESS_KEY_ID"` |  |
| server.extraSecretEnvironmentVars[0].secretName | string | `"eks-creds"` |  |
| server.extraSecretEnvironmentVars[0].secretKey | string | `"AWS_ACCESS_KEY_ID"` |  |
| server.extraSecretEnvironmentVars[1].envName | string | `"AWS_SECRET_ACCESS_KEY"` |  |
| server.extraSecretEnvironmentVars[1].secretName | string | `"eks-creds"` |  |
| server.extraSecretEnvironmentVars[1].secretKey | string | `"AWS_SECRET_ACCESS_KEY"` |  |
| server.enterpriseLicense.secretName | string | `""` |  |
| server.enterpriseLicense.secretKey | string | `"license"` |  |
| server.image.repository | string | `"registry1.dso.mil/ironbank/hashicorp/vault/vault"` |  |
| server.image.tag | string | `"1.8.3"` |  |
| server.image.pullPolicy | string | `"IfNotPresent"` |  |
| server.updateStrategyType | string | `"OnDelete"` |  |
| server.logLevel | string | `""` |  |
| server.logFormat | string | `""` |  |
| server.resources.requests.memory | string | `"256Mi"` |  |
| server.resources.requests.cpu | string | `"250m"` |  |
| server.resources.limits.memory | string | `"256Mi"` |  |
| server.resources.limits.cpu | string | `"250m"` |  |
| server.ingress.enabled | bool | `false` |  |
| server.ingress.labels | object | `{}` |  |
| server.ingress.annotations | object | `{}` |  |
| server.ingress.activeService | bool | `true` |  |
| server.ingress.hosts[0].host | string | `"chart-example.local"` |  |
| server.ingress.hosts[0].paths | list | `[]` |  |
| server.ingress.extraPaths | list | `[]` |  |
| server.ingress.tls | list | `[]` |  |
| server.route.enabled | bool | `false` |  |
| server.route.activeService | bool | `true` |  |
| server.route.labels | object | `{}` |  |
| server.route.annotations | object | `{}` |  |
| server.route.host | string | `"chart-example.local"` |  |
| server.authDelegator.enabled | bool | `true` |  |
| server.extraInitContainers | string | `nil` |  |
| server.extraContainers | string | `nil` |  |
| server.shareProcessNamespace | bool | `false` |  |
| server.extraArgs | string | `""` |  |
| server.readinessProbe.enabled | bool | `true` |  |
| server.readinessProbe.failureThreshold | int | `2` |  |
| server.readinessProbe.initialDelaySeconds | int | `5` |  |
| server.readinessProbe.periodSeconds | int | `5` |  |
| server.readinessProbe.successThreshold | int | `1` |  |
| server.readinessProbe.timeoutSeconds | int | `3` |  |
| server.livenessProbe.enabled | bool | `false` |  |
| server.livenessProbe.path | string | `"/v1/sys/health?standbyok=true"` |  |
| server.livenessProbe.failureThreshold | int | `2` |  |
| server.livenessProbe.initialDelaySeconds | int | `60` |  |
| server.livenessProbe.periodSeconds | int | `5` |  |
| server.livenessProbe.successThreshold | int | `1` |  |
| server.livenessProbe.timeoutSeconds | int | `3` |  |
| server.preStopSleepSeconds | int | `5` |  |
| server.postStart | list | `[]` |  |
| server.extraEnvironmentVars | object | `{}` |  |
| server.extraSecretEnvironmentVars | list | `[]` |  |
| server.extraVolumes | list | `[]` |  |
| server.volumes | string | `nil` |  |
| server.volumeMounts | string | `nil` |  |
| server.affinity | string | `"podAntiAffinity:\n  requiredDuringSchedulingIgnoredDuringExecution:\n    - labelSelector:\n        matchLabels:\n          app.kubernetes.io/name: {{ template \"vault.name\" . }}\n          app.kubernetes.io/instance: \"{{ .Release.Name }}\"\n          component: server\n      topologyKey: kubernetes.io/hostname\n"` |  |
| server.tolerations | list | `[]` |  |
| server.nodeSelector | object | `{}` |  |
| server.networkPolicy.enabled | bool | `false` |  |
| server.networkPolicy.egress | list | `[]` |  |
| server.priorityClassName | string | `""` |  |
| server.extraLabels | object | `{}` |  |
| server.annotations | object | `{}` |  |
| server.service.enabled | bool | `true` |  |
| server.service.port | int | `8200` |  |
| server.service.targetPort | int | `8200` |  |
| server.service.annotations | object | `{}` |  |
| server.dataStorage.enabled | bool | `true` |  |
| server.dataStorage.size | string | `"10Gi"` |  |
| server.dataStorage.mountPath | string | `"/vault/data"` |  |
| server.dataStorage.storageClass | string | `nil` |  |
| server.dataStorage.accessMode | string | `"ReadWriteOnce"` |  |
| server.dataStorage.annotations | object | `{}` |  |
| server.auditStorage.enabled | bool | `true` |  |
| server.auditStorage.size | string | `"10Gi"` |  |
| server.auditStorage.mountPath | string | `"/vault/audit"` |  |
| server.auditStorage.storageClass | string | `nil` |  |
| server.auditStorage.accessMode | string | `"ReadWriteOnce"` |  |
| server.auditStorage.annotations | object | `{}` |  |
| server.dev.enabled | bool | `false` |  |
| server.dev.devRootToken | string | `"root"` |  |
| server.standalone.enabled | string | `"-"` |  |
| server.standalone.config | string | `"ui = true\n\nlistener \"tcp\" {\n  tls_disable = 1\n  address = \"[::]:8200\"\n  cluster_address = \"[::]:8201\"\n}\n\ntelemetry {\n  prometheus_retention_time = \"24h\"\n  disable_hostname = true\n  unauthenticated_metrics_access = true\n}\n\n{{- if .Values.server.dataStorage.enabled }}\nstorage \"raft\" {\n  path = \"/vault/data\"\n}\n{{- end }}\n\n{{- if and (not .Values.server.dataStorage.enabled) .Values.minio.enabled }}\nstorage \"s3\" {\n    access_key = \"{{ .Values.minio.accessKey }}\"\n    secret_key = \"{{ .Values.minio.secretKey }}\"\n    endpoint = \"{{ .Values.minio.endpoint }}\"\n    bucket = \"{{ .Values.minio.bucketName }}\"\n    s3_force_path_style = \"true\"\n    disable_ssl = \"{{ .Values.minio.disableSSL }}\"\n}\n{{- end }}\n\n# Example configuration for using auto-unseal, using Google Cloud KMS. The\n# GKMS keys must already exist, and the cluster must have a service account\n# that is authorized to access GCP KMS.\n#seal \"gcpckms\" {\n#   project     = \"vault-helm-dev\"\n#   region      = \"global\"\n#   key_ring    = \"vault-helm-unseal-kr\"\n#   crypto_key  = \"vault-helm-unseal-key\"\n#}\n"` |  |
| server.ha.enabled | bool | `false` |  |
| server.ha.replicas | int | `3` |  |
| server.ha.apiAddr | string | `nil` |  |
| server.ha.raft.enabled | bool | `true` |  |
| server.ha.raft.setNodeId | bool | `false` |  |
| server.ha.raft.config | string | `"ui = true\n\nlistener \"tcp\" {\n  tls_disable = 1\n  address = \"[::]:8200\"\n  cluster_address = \"[::]:8201\"\n}\n\nstorage \"raft\" {\n  path = \"/vault/data\"\n}\n\ntelemetry {\n  prometheus_retention_time = \"24h\"\n  disable_hostname = true\n  unauthenticated_metrics_access = true\n}\n\n\nservice_registration \"kubernetes\" {}\n"` |  |
| server.ha.config | string | `"ui = true\n\nlistener \"tcp\" {\n  tls_disable = 1\n  address = \"[::]:8200\"\n  cluster_address = \"[::]:8201\"\n}\nstorage \"consul\" {\n  path = \"vault\"\n  address = \"HOST_IP:8500\"\n}\n\nservice_registration \"kubernetes\" {}\n\n# Example configuration for using auto-unseal, using Google Cloud KMS. The\n# GKMS keys must already exist, and the cluster must have a service account\n# that is authorized to access GCP KMS.\n#seal \"gcpckms\" {\n#   project     = \"vault-helm-dev-246514\"\n#   region      = \"global\"\n#   key_ring    = \"vault-helm-unseal-kr\"\n#   crypto_key  = \"vault-helm-unseal-key\"\n#}\n"` |  |
| server.ha.disruptionBudget.enabled | bool | `true` |  |
| server.ha.disruptionBudget.maxUnavailable | string | `nil` |  |
| server.serviceAccount.create | bool | `true` |  |
| server.serviceAccount.name | string | `""` |  |
| server.serviceAccount.annotations | object | `{}` |  |
| server.statefulSet.annotations | object | `{}` |  |
| ui.enabled | bool | `false` |  |
| ui.publishNotReadyAddresses | bool | `true` |  |
| ui.activeVaultPodOnly | bool | `false` |  |
| ui.serviceType | string | `"ClusterIP"` |  |
| ui.serviceNodePort | string | `nil` |  |
| ui.externalPort | int | `8200` |  |
| ui.targetPort | int | `8200` |  |
| ui.annotations | object | `{}` |  |
| csi.enabled | bool | `false` |  |
| csi.image.repository | string | `"registry.dso.mil/platform-one/big-bang/apps/sandbox/vault/vault-csi-provider"` |  |
| csi.image.tag | string | `"0.3.0"` |  |
| csi.image.pullPolicy | string | `"IfNotPresent"` |  |
| csi.volumes | string | `nil` |  |
| csi.volumeMounts | string | `nil` |  |
| csi.resources.requests.cpu | string | `"50m"` |  |
| csi.resources.requests.memory | string | `"128Mi"` |  |
| csi.resources.limits.cpu | string | `"50m"` |  |
| csi.resources.limits.memory | string | `"128Mi"` |  |
| csi.daemonSet.updateStrategy.type | string | `"RollingUpdate"` |  |
| csi.daemonSet.updateStrategy.maxUnavailable | string | `""` |  |
| csi.daemonSet.annotations | object | `{}` |  |
| csi.pod.annotations | object | `{}` |  |
| csi.pod.tolerations | list | `[]` |  |
| csi.serviceAccount.annotations | object | `{}` |  |
| csi.readinessProbe.failureThreshold | int | `2` |  |
| csi.readinessProbe.initialDelaySeconds | int | `5` |  |
| csi.readinessProbe.periodSeconds | int | `5` |  |
| csi.readinessProbe.successThreshold | int | `1` |  |
| csi.readinessProbe.timeoutSeconds | int | `3` |  |
| csi.livenessProbe.failureThreshold | int | `2` |  |
| csi.livenessProbe.initialDelaySeconds | int | `5` |  |
| csi.livenessProbe.periodSeconds | int | `5` |  |
| csi.livenessProbe.successThreshold | int | `1` |  |
| csi.livenessProbe.timeoutSeconds | int | `3` |  |
| csi.debug | bool | `false` |  |
| csi.extraArgs | list | `[]` |  |
| domain | string | `"bigbang.dev"` |  |
| monitoring.enabled | bool | `false` |  |
| monitoring.namespace | string | `"monitoring"` |  |
| networkPolicies.enabled | bool | `false` |  |
| networkPolicies.ingressLabels.app | string | `"istio-ingressgateway"` |  |
| networkPolicies.ingressLabels.istio | string | `"ingressgateway"` |  |
| autoInit.enabled | bool | `true` |  |
| istio.enabled | bool | `false` |  |
| istio.vault.gateways[0] | string | `"istio-system/main"` |  |
| istio.vault.hosts[0] | string | `"vault.{{ .Values.domain }}"` |  |
| minio.enabled | bool | `false` |  |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.
