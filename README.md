<!-- Warning: Do not manually edit this file. See notes on gluon + helm-docs at the end of this file for more information. -->
# vault

![Version: 0.30.0-bb.7](https://img.shields.io/badge/Version-0.30.0--bb.7-informational?style=flat-square) ![AppVersion: 1.19.5](https://img.shields.io/badge/AppVersion-1.19.5-informational?style=flat-square) ![Maintenance Track: bb_integrated](https://img.shields.io/badge/Maintenance_Track-bb_integrated-green?style=flat-square)

Official HashiCorp Vault Chart

## Upstream References

- <https://www.vaultproject.io>
- <https://github.com/hashicorp/vault>
- <https://github.com/hashicorp/vault-helm>
- <https://github.com/hashicorp/vault-k8s>
- <https://github.com/hashicorp/vault-csi-provider>

## Upstream Release Notes

This package has no upstream release note links on file. Please add some to [chart/Chart.yaml](chart/Chart.yaml) under `annotations.bigbang.dev/upstreamReleaseNotesMarkdown`.
Example:
```yaml
annotations:
  bigbang.dev/upstreamReleaseNotesMarkdown: |
    - [Find our upstream chart's CHANGELOG here](https://link-goes-here/CHANGELOG.md)
    - [and our upstream application release notes here](https://another-link-here/RELEASE_NOTES.md)
```

## Learn More

- [Application Overview](docs/overview.md)
- [Other Documentation](docs/)

## Pre-Requisites

- Kubernetes Cluster deployed
- Kubernetes config installed in `~/.kube/config`
- Helm installed

Kubernetes: `>= 1.20.0-0`

Install Helm

https://helm.sh/docs/intro/install/

## Deployment

- Clone down the repository
- cd into directory

```bash
helm install vault chart/
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.enabled | bool | `true` |  |
| global.namespace | string | `""` |  |
| global.imagePullSecrets[0].name | string | `"private-registry"` |  |
| global.tlsDisable | bool | `true` |  |
| global.externalVaultAddr | string | `""` |  |
| global.openshift | bool | `false` |  |
| global.psp.enable | bool | `false` |  |
| global.psp.annotations | string | `"seccomp.security.alpha.kubernetes.io/allowedProfileNames: docker/default,runtime/default\napparmor.security.beta.kubernetes.io/allowedProfileNames: runtime/default\nseccomp.security.alpha.kubernetes.io/defaultProfileName:  runtime/default\napparmor.security.beta.kubernetes.io/defaultProfileName:  runtime/default\n"` |  |
| global.serverTelemetry.prometheusOperator | bool | `false` |  |
| injector.enabled | string | `"-"` |  |
| injector.replicas | int | `1` |  |
| injector.port | int | `8080` |  |
| injector.leaderElector.enabled | bool | `false` |  |
| injector.metrics.enabled | bool | `true` |  |
| injector.externalVaultAddr | string | `""` |  |
| injector.image.repository | string | `"registry1.dso.mil/ironbank/hashicorp/vault/vault-k8s"` |  |
| injector.image.tag | string | `"v1.6.2"` |  |
| injector.image.pullPolicy | string | `"IfNotPresent"` |  |
| injector.agentImage.repository | string | `"registry1.dso.mil/ironbank/hashicorp/vault"` |  |
| injector.agentImage.tag | string | `"1.19.5"` |  |
| injector.agentDefaults.cpuLimit | string | `"500m"` |  |
| injector.agentDefaults.cpuRequest | string | `"500m"` |  |
| injector.agentDefaults.memLimit | string | `"250Mi"` |  |
| injector.agentDefaults.memRequest | string | `"250Mi"` |  |
| injector.agentDefaults.template | string | `"map"` |  |
| injector.agentDefaults.templateConfig.exitOnRetryFailure | bool | `true` |  |
| injector.agentDefaults.templateConfig.staticSecretRenderInterval | string | `""` |  |
| injector.livenessProbe.failureThreshold | int | `2` |  |
| injector.livenessProbe.initialDelaySeconds | int | `5` |  |
| injector.livenessProbe.periodSeconds | int | `2` |  |
| injector.livenessProbe.successThreshold | int | `1` |  |
| injector.livenessProbe.timeoutSeconds | int | `5` |  |
| injector.readinessProbe.failureThreshold | int | `2` |  |
| injector.readinessProbe.initialDelaySeconds | int | `5` |  |
| injector.readinessProbe.periodSeconds | int | `2` |  |
| injector.readinessProbe.successThreshold | int | `1` |  |
| injector.readinessProbe.timeoutSeconds | int | `5` |  |
| injector.startupProbe.failureThreshold | int | `12` |  |
| injector.startupProbe.initialDelaySeconds | int | `5` |  |
| injector.startupProbe.periodSeconds | int | `5` |  |
| injector.startupProbe.successThreshold | int | `1` |  |
| injector.startupProbe.timeoutSeconds | int | `5` |  |
| injector.authPath | string | `"auth/kubernetes"` |  |
| injector.logLevel | string | `"info"` |  |
| injector.logFormat | string | `"standard"` |  |
| injector.revokeOnShutdown | bool | `false` |  |
| injector.webhook.failurePolicy | string | `"Ignore"` |  |
| injector.webhook.matchPolicy | string | `"Exact"` |  |
| injector.webhook.timeoutSeconds | int | `30` |  |
| injector.webhook.namespaceSelector | object | `{}` |  |
| injector.webhook.objectSelector | string | `"matchExpressions:\n- key: app.kubernetes.io/name\n  operator: NotIn\n  values:\n  - {{ template \"vault.name\" . }}-agent-injector\n"` |  |
| injector.webhook.annotations | object | `{}` |  |
| injector.failurePolicy | string | `"Ignore"` |  |
| injector.namespaceSelector | object | `{}` |  |
| injector.objectSelector | object | `{}` |  |
| injector.webhookAnnotations | object | `{}` |  |
| injector.certs.secretName | string | `nil` |  |
| injector.certs.caBundle | string | `""` |  |
| injector.certs.certName | string | `"tls.crt"` |  |
| injector.certs.keyName | string | `"tls.key"` |  |
| injector.securityContext.pod | object | `{}` |  |
| injector.securityContext.container.capabilities.drop[0] | string | `"ALL"` |  |
| injector.resources.requests.memory | string | `"256Mi"` |  |
| injector.resources.requests.cpu | string | `"250m"` |  |
| injector.resources.limits.memory | string | `"256Mi"` |  |
| injector.resources.limits.cpu | string | `"250m"` |  |
| injector.extraEnvironmentVars | object | `{}` |  |
| injector.affinity | string | `"podAntiAffinity:\n  requiredDuringSchedulingIgnoredDuringExecution:\n    - labelSelector:\n        matchLabels:\n          app.kubernetes.io/name: {{ template \"vault.name\" . }}-agent-injector\n          app.kubernetes.io/instance: \"{{ .Release.Name }}\"\n          component: webhook\n      topologyKey: kubernetes.io/hostname\n"` |  |
| injector.topologySpreadConstraints | list | `[]` |  |
| injector.tolerations | list | `[]` |  |
| injector.nodeSelector | object | `{}` |  |
| injector.priorityClassName | string | `""` |  |
| injector.annotations | object | `{}` |  |
| injector.extraLabels | object | `{}` |  |
| injector.hostNetwork | bool | `false` |  |
| injector.service.annotations | object | `{}` |  |
| injector.serviceAccount.annotations | object | `{}` |  |
| injector.podDisruptionBudget | object | `{}` |  |
| injector.strategy | object | `{}` |  |
| server.enabled | bool | `true` |  |
| server.extraSecretEnvironmentVars[0].envName | string | `"AWS_ACCESS_KEY_ID"` |  |
| server.extraSecretEnvironmentVars[0].secretName | string | `"eks-creds"` |  |
| server.extraSecretEnvironmentVars[0].secretKey | string | `"AWS_ACCESS_KEY_ID"` |  |
| server.extraSecretEnvironmentVars[1].envName | string | `"AWS_SECRET_ACCESS_KEY"` |  |
| server.extraSecretEnvironmentVars[1].secretName | string | `"eks-creds"` |  |
| server.extraSecretEnvironmentVars[1].secretKey | string | `"AWS_SECRET_ACCESS_KEY"` |  |
| server.enterpriseLicense.secretName | string | `""` |  |
| server.enterpriseLicense.secretKey | string | `"license"` |  |
| server.image.repository | string | `"registry1.dso.mil/ironbank/hashicorp/vault"` |  |
| server.image.tag | string | `"1.19.5"` |  |
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
| server.ingress.ingressClassName | string | `""` |  |
| server.ingress.pathType | string | `"Prefix"` |  |
| server.ingress.activeService | bool | `true` |  |
| server.ingress.hosts[0].host | string | `"chart-example.local"` |  |
| server.ingress.hosts[0].paths | list | `[]` |  |
| server.ingress.extraPaths | list | `[]` |  |
| server.ingress.tls | list | `[]` |  |
| server.hostAliases | list | `[]` |  |
| server.route.enabled | bool | `false` |  |
| server.route.activeService | bool | `true` |  |
| server.route.labels | object | `{}` |  |
| server.route.annotations | object | `{}` |  |
| server.route.host | string | `"chart-example.local"` |  |
| server.route.tls.termination | string | `"passthrough"` |  |
| server.authDelegator.enabled | bool | `true` |  |
| server.extraInitContainers | string | `nil` |  |
| server.extraContainers | string | `nil` |  |
| server.shareProcessNamespace | bool | `false` |  |
| server.extraArgs | string | `""` |  |
| server.extraPorts | string | `nil` |  |
| server.readinessProbe.enabled | bool | `true` |  |
| server.readinessProbe.port | int | `8200` |  |
| server.readinessProbe.failureThreshold | int | `2` |  |
| server.readinessProbe.initialDelaySeconds | int | `5` |  |
| server.readinessProbe.periodSeconds | int | `5` |  |
| server.readinessProbe.successThreshold | int | `1` |  |
| server.readinessProbe.timeoutSeconds | int | `3` |  |
| server.livenessProbe.enabled | bool | `false` |  |
| server.livenessProbe.execCommand | list | `[]` |  |
| server.livenessProbe.path | string | `"/v1/sys/health?standbyok=true"` |  |
| server.livenessProbe.port | int | `8200` |  |
| server.livenessProbe.failureThreshold | int | `2` |  |
| server.livenessProbe.initialDelaySeconds | int | `60` |  |
| server.livenessProbe.periodSeconds | int | `5` |  |
| server.livenessProbe.successThreshold | int | `1` |  |
| server.livenessProbe.timeoutSeconds | int | `3` |  |
| server.terminationGracePeriodSeconds | int | `10` |  |
| server.preStopSleepSeconds | int | `5` |  |
| server.preStop | list | `[]` |  |
| server.postStart | list | `[]` |  |
| server.extraEnvironmentVars | object | `{}` |  |
| server.extraSecretEnvironmentVars | list | `[]` |  |
| server.extraVolumes | list | `[]` |  |
| server.volumes | string | `nil` |  |
| server.volumeMounts | string | `nil` |  |
| server.affinity | string | `"podAntiAffinity:\n  requiredDuringSchedulingIgnoredDuringExecution:\n    - labelSelector:\n        matchLabels:\n          app.kubernetes.io/name: {{ template \"vault.name\" . }}\n          app.kubernetes.io/instance: \"{{ .Release.Name }}\"\n          component: server\n      topologyKey: kubernetes.io/hostname\n"` |  |
| server.topologySpreadConstraints | list | `[]` |  |
| server.tolerations | list | `[]` |  |
| server.nodeSelector | object | `{}` |  |
| server.networkPolicy.enabled | bool | `false` |  |
| server.networkPolicy.egress | list | `[]` |  |
| server.networkPolicy.ingress[0].from[0].namespaceSelector | object | `{}` |  |
| server.networkPolicy.ingress[0].ports[0].port | int | `8200` |  |
| server.networkPolicy.ingress[0].ports[0].protocol | string | `"TCP"` |  |
| server.networkPolicy.ingress[0].ports[1].port | int | `8201` |  |
| server.networkPolicy.ingress[0].ports[1].protocol | string | `"TCP"` |  |
| server.priorityClassName | string | `""` |  |
| server.extraLabels | object | `{}` |  |
| server.annotations | object | `{}` |  |
| server.includeConfigAnnotation | bool | `false` |  |
| server.service.enabled | bool | `true` |  |
| server.service.active.enabled | bool | `true` |  |
| server.service.active.annotations | object | `{}` |  |
| server.service.standby.enabled | bool | `true` |  |
| server.service.standby.annotations | object | `{}` |  |
| server.service.instanceSelector.enabled | bool | `true` |  |
| server.service.ipFamilyPolicy | string | `""` |  |
| server.service.ipFamilies | list | `[]` |  |
| server.service.publishNotReadyAddresses | bool | `true` |  |
| server.service.externalTrafficPolicy | string | `"Cluster"` |  |
| server.service.port | int | `8200` |  |
| server.service.targetPort | int | `8200` |  |
| server.service.annotations | object | `{}` |  |
| server.dataStorage.enabled | bool | `true` |  |
| server.dataStorage.size | string | `"10Gi"` |  |
| server.dataStorage.mountPath | string | `"/vault/data"` |  |
| server.dataStorage.storageClass | string | `nil` |  |
| server.dataStorage.accessMode | string | `"ReadWriteOnce"` |  |
| server.dataStorage.annotations | object | `{}` |  |
| server.dataStorage.labels | object | `{}` |  |
| server.persistentVolumeClaimRetentionPolicy | object | `{}` |  |
| server.auditStorage.enabled | bool | `true` |  |
| server.auditStorage.size | string | `"10Gi"` |  |
| server.auditStorage.mountPath | string | `"/vault/audit"` |  |
| server.auditStorage.storageClass | string | `nil` |  |
| server.auditStorage.accessMode | string | `"ReadWriteOnce"` |  |
| server.auditStorage.annotations | object | `{}` |  |
| server.auditStorage.labels | object | `{}` |  |
| server.dev.enabled | bool | `false` |  |
| server.dev.devRootToken | string | `"root"` |  |
| server.standalone.enabled | string | `"-"` |  |
| server.standalone.config | string | `"ui = true\n\nlistener \"tcp\" {\n  {{- if and .Values.istio.vault.tls.cert .Values.istio.vault.tls.key (not .Values.global.tlsDisable) }}\n  tls_disable = 0\n  tls_key_file = \"/vault/tls/tls.key\"\n  tls_cert_file = \"/vault/tls/tls.crt\"\n  {{- else }}\n  tls_disable = 1\n  {{- end }}\n  address = \"[::]:8200\"\n  cluster_address = \"[::]:8201\"\n  # Enable unauthenticated metrics access (necessary for Prometheus Operator)\n  #telemetry {\n  #  unauthenticated_metrics_access = \"true\"\n  #}\n}\n\ntelemetry {\n  prometheus_retention_time = \"24h\"\n  disable_hostname = true\n  unauthenticated_metrics_access = true\n}\n\n{{- if .Values.server.dataStorage.enabled }}\nstorage \"raft\" {\n  path = \"/vault/data\"\n}\n{{- end }}\n\n{{- if and (not .Values.server.dataStorage.enabled) .Values.minio.enabled }}\nstorage \"s3\" {\n    access_key = \"{{ .Values.minio.accessKey }}\"\n    secret_key = \"{{ .Values.minio.secretKey }}\"\n    endpoint = \"{{ .Values.minio.endpoint }}\"\n    bucket = \"{{ .Values.minio.bucketName }}\"\n    s3_force_path_style = \"true\"\n    disable_ssl = \"{{ .Values.minio.disableSSL }}\"\n}\n{{- end }}\n\n# Example configuration for using auto-unseal, using Google Cloud KMS. The\n# GKMS keys must already exist, and the cluster must have a service account\n# that is authorized to access GCP KMS.\n#seal \"gcpckms\" {\n#   project     = \"vault-helm-dev\"\n#   region      = \"global\"\n#   key_ring    = \"vault-helm-unseal-kr\"\n#   crypto_key  = \"vault-helm-unseal-key\"\n#}\n\n# Example configuration for enabling Prometheus metrics in your config.\n#telemetry {\n#  prometheus_retention_time = \"30s\"\n#  disable_hostname = true\n#}"` |  |
| server.ha.enabled | bool | `false` |  |
| server.ha.replicas | int | `3` |  |
| server.ha.apiAddr | string | `nil` |  |
| server.ha.clusterAddr | string | `nil` |  |
| server.ha.raft.enabled | bool | `true` |  |
| server.ha.raft.setNodeId | bool | `true` |  |
| server.ha.raft.config | string | `"ui = true\n\nlistener \"tcp\" {\n  {{- if and .Values.istio.vault.tls.cert .Values.istio.vault.tls.key (not .Values.global.tlsDisable) }}\n  tls_disable = 0\n  tls_key_file = \"/vault/tls/tls.key\"\n  tls_cert_file = \"/vault/tls/tls.crt\"\n  {{- else }}\n  tls_disable = 1\n  {{- end }}\n  address = \"[::]:8200\"\n  cluster_address = \"[::]:8201\"\n  # Enable unauthenticated metrics access (necessary for Prometheus Operator)\n  #telemetry {\n  #  unauthenticated_metrics_access = \"true\"\n  #}\n}\n\nstorage \"raft\" {\n  path = \"/vault/data\"\n}\n\ntelemetry {\n  prometheus_retention_time = \"24h\"\n  disable_hostname = true\n  unauthenticated_metrics_access = true\n}\n\n\nservice_registration \"kubernetes\" {}\n"` |  |
| server.ha.config | string | `"ui = true\n\nlistener \"tcp\" {\n  {{- if and .Values.istio.vault.tls.cert .Values.istio.vault.tls.key (not .Values.global.tlsDisable) }}\n  tls_disable = 0\n  tls_key_file = \"/vault/tls/tls.key\"\n  tls_cert_file = \"/vault/tls/tls.crt\"\n  {{- else }}\n  tls_disable = 1\n  {{- end }}\n  address = \"[::]:8200\"\n  cluster_address = \"[::]:8201\"\n}\nstorage \"consul\" {\n  path = \"vault\"\n  address = \"HOST_IP:8500\"\n}\n\nservice_registration \"kubernetes\" {}\n\n# Example configuration for using auto-unseal, using Google Cloud KMS. The\n# GKMS keys must already exist, and the cluster must have a service account\n# that is authorized to access GCP KMS.\n#seal \"gcpckms\" {\n#   project     = \"vault-helm-dev-246514\"\n#   region      = \"global\"\n#   key_ring    = \"vault-helm-unseal-kr\"\n#   crypto_key  = \"vault-helm-unseal-key\"\n#}\n\n# Example configuration for enabling Prometheus metrics.\n# If you are using Prometheus Operator you can enable a ServiceMonitor resource below.\n# You may wish to enable unauthenticated metrics in the listener block above.\n#telemetry {\n#  prometheus_retention_time = \"30s\"\n#  disable_hostname = true\n#}\n"` |  |
| server.ha.disruptionBudget.enabled | bool | `true` |  |
| server.ha.disruptionBudget.maxUnavailable | string | `nil` |  |
| server.serviceAccount.create | bool | `true` |  |
| server.serviceAccount.name | string | `""` |  |
| server.serviceAccount.createSecret | bool | `false` |  |
| server.serviceAccount.annotations | object | `{}` |  |
| server.serviceAccount.extraLabels | object | `{}` |  |
| server.serviceAccount.serviceDiscovery.enabled | bool | `true` |  |
| server.statefulSet.annotations | object | `{}` |  |
| server.statefulSet.securityContext.pod | object | `{}` |  |
| server.statefulSet.securityContext.container.capabilities.drop[0] | string | `"ALL"` |  |
| server.hostNetwork | bool | `false` |  |
| ui.enabled | bool | `true` |  |
| ui.publishNotReadyAddresses | bool | `true` |  |
| ui.activeVaultPodOnly | bool | `false` |  |
| ui.serviceType | string | `"ClusterIP"` |  |
| ui.serviceNodePort | string | `nil` |  |
| ui.externalPort | int | `8200` |  |
| ui.targetPort | int | `8200` |  |
| ui.serviceIPFamilyPolicy | string | `""` |  |
| ui.serviceIPFamilies | list | `[]` |  |
| ui.externalTrafficPolicy | string | `"Cluster"` |  |
| ui.annotations | object | `{}` |  |
| csi.enabled | bool | `false` |  |
| csi.image.repository | string | `"registry1.dso.mil/ironbank/hashicorp/vault-csi-provider"` |  |
| csi.image.tag | string | `"v1.5.0"` |  |
| csi.image.pullPolicy | string | `"IfNotPresent"` |  |
| csi.volumes | string | `nil` |  |
| csi.volumeMounts | string | `nil` |  |
| csi.resources.requests.cpu | string | `"50m"` |  |
| csi.resources.requests.memory | string | `"128Mi"` |  |
| csi.resources.limits.cpu | string | `"50m"` |  |
| csi.resources.limits.memory | string | `"128Mi"` |  |
| csi.hmacSecretName | string | `""` |  |
| csi.hostNetwork | bool | `false` |  |
| csi.daemonSet.updateStrategy.type | string | `"RollingUpdate"` |  |
| csi.daemonSet.updateStrategy.maxUnavailable | string | `""` |  |
| csi.daemonSet.annotations | object | `{}` |  |
| csi.daemonSet.providersDir | string | `"/etc/kubernetes/secrets-store-csi-providers"` |  |
| csi.daemonSet.kubeletRootDir | string | `"/var/lib/kubelet"` |  |
| csi.daemonSet.extraLabels | object | `{}` |  |
| csi.daemonSet.securityContext.pod.runAsNonRoot | bool | `true` |  |
| csi.daemonSet.securityContext.pod.runAsGroup | int | `1000` |  |
| csi.daemonSet.securityContext.pod.runAsUser | int | `100` |  |
| csi.daemonSet.securityContext.pod.fsGroup | int | `1000` |  |
| csi.pod.annotations | object | `{}` |  |
| csi.pod.tolerations | list | `[]` |  |
| csi.pod.nodeSelector | object | `{}` |  |
| csi.pod.affinity | object | `{}` |  |
| csi.pod.extraLabels | object | `{}` |  |
| csi.agent.enabled | bool | `true` |  |
| csi.agent.extraArgs | list | `[]` |  |
| csi.agent.image.repository | string | `"registry1.dso.mil/ironbank/hashicorp/vault"` |  |
| csi.agent.image.tag | string | `"1.19.5"` |  |
| csi.agent.image.pullPolicy | string | `"IfNotPresent"` |  |
| csi.agent.logFormat | string | `"standard"` |  |
| csi.agent.logLevel | string | `"info"` |  |
| csi.agent.resources.requests.memory | string | `"256Mi"` |  |
| csi.agent.resources.requests.cpu | string | `"250m"` |  |
| csi.agent.resources.limits.memory | string | `"256Mi"` |  |
| csi.agent.resources.limits.cpu | string | `"250m"` |  |
| csi.priorityClassName | string | `""` |  |
| csi.serviceAccount.annotations | object | `{}` |  |
| csi.serviceAccount.extraLabels | object | `{}` |  |
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
| csi.logLevel | string | `"info"` |  |
| csi.debug | bool | `false` |  |
| csi.extraArgs | list | `[]` |  |
| domain | string | `"dev.bigbang.mil"` |  |
| monitoring.enabled | bool | `false` |  |
| monitoring.namespace | string | `"monitoring"` |  |
| networkPolicies.enabled | bool | `false` |  |
| networkPolicies.controlPlaneCidr | string | `"0.0.0.0/0"` |  |
| networkPolicies.vpcCidr | string | `"0.0.0.0/0"` |  |
| networkPolicies.ingressLabels.app | string | `"istio-ingressgateway"` |  |
| networkPolicies.ingressLabels.istio | string | `"ingressgateway"` |  |
| networkPolicies.additionalPolicies | list | `[]` |  |
| autoInit.enabled | bool | `true` |  |
| autoInit.image.repository | string | `"registry1.dso.mil/ironbank/big-bang/base"` |  |
| autoInit.image.tag | string | `"2.1.0"` |  |
| autoInit.storage.size | string | `"2Gi"` |  |
| istio.enabled | bool | `false` |  |
| istio.hardened.enabled | bool | `false` |  |
| istio.hardened.customAuthorizationPolicies | list | `[]` |  |
| istio.hardened.monitoring.enabled | bool | `true` |  |
| istio.hardened.monitoring.namespaces[0] | string | `"monitoring"` |  |
| istio.hardened.monitoring.principals[0] | string | `"cluster.local/ns/monitoring/sa/monitoring-grafana"` |  |
| istio.hardened.monitoring.principals[1] | string | `"cluster.local/ns/monitoring/sa/monitoring-monitoring-kube-alertmanager"` |  |
| istio.hardened.monitoring.principals[2] | string | `"cluster.local/ns/monitoring/sa/monitoring-monitoring-kube-operator"` |  |
| istio.hardened.monitoring.principals[3] | string | `"cluster.local/ns/monitoring/sa/monitoring-monitoring-kube-prometheus"` |  |
| istio.hardened.monitoring.principals[4] | string | `"cluster.local/ns/monitoring/sa/monitoring-monitoring-kube-state-metrics"` |  |
| istio.hardened.monitoring.principals[5] | string | `"cluster.local/ns/monitoring/sa/monitoring-monitoring-prometheus-node-exporter"` |  |
| istio.hardened.apiAccess.enabled | bool | `true` |  |
| istio.hardened.apiAccess.ports[0] | string | `"8200"` |  |
| istio.vault.enabled | bool | `true` |  |
| istio.vault.gateways[0] | string | `"istio-system/main"` |  |
| istio.vault.hosts[0] | string | `"vault.{{ .Values.domain }}"` |  |
| istio.vault.tls.cert | string | `""` |  |
| istio.vault.tls.key | string | `""` |  |
| istio.mtls.mode | string | `"STRICT"` |  |
| minio.enabled | bool | `false` |  |
| customAppIngressSelector.key | string | `"vault-ingress"` |  |
| customAppIngressSelector.value | bool | `true` |  |
| serverTelemetry.serviceMonitor.enabled | bool | `false` |  |
| serverTelemetry.serviceMonitor.selectors | object | `{}` |  |
| serverTelemetry.serviceMonitor.interval | string | `"30s"` |  |
| serverTelemetry.serviceMonitor.scrapeTimeout | string | `"10s"` |  |
| serverTelemetry.serviceMonitor.tlsConfig | object | `{}` |  |
| serverTelemetry.serviceMonitor.authorization | object | `{}` |  |
| serverTelemetry.prometheusRules.enabled | bool | `false` |  |
| serverTelemetry.prometheusRules.selectors | object | `{}` |  |
| serverTelemetry.prometheusRules.rules | list | `[]` |  |
| bbtests.enabled | bool | `false` |  |
| bbtests.cypress.resources.requests.cpu | int | `2` |  |
| bbtests.cypress.resources.requests.memory | string | `"8Gi"` |  |
| bbtests.cypress.resources.limits.cpu | int | `2` |  |
| bbtests.cypress.resources.limits.memory | string | `"8Gi"` |  |
| bbtests.cypress.artifacts | bool | `true` |  |
| bbtests.cypress.envs.cypress_vault_url | string | `"http://vault.vault.svc:8200"` |  |
| bbtests.cypress.secretEnvs[0].name | string | `"cypress_token"` |  |
| bbtests.cypress.secretEnvs[0].valueFrom.secretKeyRef.name | string | `"vault-token"` |  |
| bbtests.cypress.secretEnvs[0].valueFrom.secretKeyRef.key | string | `"key"` |  |
| bbtests.cypress.disableDefaultTests | bool | `false` |  |
| openshift | bool | `false` |  |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.

---

_This file is programatically generated using `helm-docs` and some BigBang-specific templates. The `gluon` repository has [instructions for regenerating package READMEs](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)._

