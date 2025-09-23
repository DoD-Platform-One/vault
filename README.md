# vault

![Version: 0.30.1-bb.6](https://img.shields.io/badge/Version-0.30.1--bb.6-informational?style=flat-square) ![AppVersion: 1.20.3](https://img.shields.io/badge/AppVersion-1.20.3-informational?style=flat-square)

Official HashiCorp Vault Chart

**Homepage:** <https://developer.hashicorp.com/vault>

## Source Code

* <https://github.com/hashicorp/vault>
* <https://github.com/hashicorp/vault-helm>
* <https://github.com/hashicorp/vault-k8s>
* <https://github.com/hashicorp/vault-csi-provider>

## Requirements

Kubernetes: `>= 1.20.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://helm.releases.hashicorp.com/ | upstream(vault) | 0.30.1 |
| oci://registry1.dso.mil/bigbang | gluon | 0.9.0 |
| oci://registry1.dso.mil/bigbang | minio(minio-instance) | 7.1.1-bb.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
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
| bbtests.scripts.permissions.apiGroups[0] | string | `""` |  |
| bbtests.scripts.permissions.resources[0] | string | `"configmaps"` |  |
| bbtests.scripts.permissions.verbs[0] | string | `"create"` |  |
| bbtests.scripts.permissions.verbs[1] | string | `"delete"` |  |
| bbtests.scripts.permissions.verbs[2] | string | `"list"` |  |
| bbtests.scripts.permissions.verbs[3] | string | `"get"` |  |
| bbtests.scripts.image | string | `"registry1.dso.mil/ironbank/big-bang/base:2.1.0"` |  |
| bbtests.scripts.envs.VAULT_PORT | string | `"80"` |  |
| bbtests.scripts.envs.VAULT_HOST | string | `"http://vault"` |  |
| bbtests.scripts.secretEnvs[0].name | string | `"vault_token"` |  |
| bbtests.scripts.secretEnvs[0].valueFrom.secretKeyRef.name | string | `"vault-token"` |  |
| bbtests.scripts.secretEnvs[0].valueFrom.secretKeyRef.key | string | `"key"` |  |
| openshift | bool | `false` |  |
| upstream.fullnameOverride | string | `"vault-vault"` |  |
| upstream.nameOverride | string | `"vault"` |  |
| upstream.global.imagePullSecrets[0].name | string | `"private-registry"` |  |
| upstream.injector.enabled | string | `"-"` |  |
| upstream.injector.leaderElector.enabled | bool | `false` |  |
| upstream.injector.metrics.enabled | bool | `true` |  |
| upstream.injector.image.repository | string | `"registry1.dso.mil/ironbank/hashicorp/vault/vault-k8s"` |  |
| upstream.injector.image.tag | string | `"v1.7.0"` |  |
| upstream.injector.agentImage.repository | string | `"registry1.dso.mil/ironbank/hashicorp/vault"` |  |
| upstream.injector.agentImage.tag | string | `"1.20.3"` |  |
| upstream.injector.agentDefaults.memLimit | string | `"250Mi"` |  |
| upstream.injector.agentDefaults.memRequest | string | `"250Mi"` |  |
| upstream.injector.securityContext.container.capabilities.drop[0] | string | `"ALL"` |  |
| upstream.injector.resources.requests.memory | string | `"256Mi"` |  |
| upstream.injector.resources.requests.cpu | string | `"250m"` |  |
| upstream.injector.resources.limits.memory | string | `"256Mi"` |  |
| upstream.injector.resources.limits.cpu | string | `"250m"` |  |
| upstream.server.enabled | bool | `true` |  |
| upstream.server.image.repository | string | `"registry1.dso.mil/ironbank/hashicorp/vault"` |  |
| upstream.server.image.tag | string | `"1.20.3"` |  |
| upstream.server.resources.requests.memory | string | `"256Mi"` |  |
| upstream.server.resources.requests.cpu | string | `"250m"` |  |
| upstream.server.resources.limits.memory | string | `"256Mi"` |  |
| upstream.server.resources.limits.cpu | string | `"250m"` |  |
| upstream.server.auditStorage.enabled | bool | `true` |  |
| upstream.server.ha.enabled | bool | `true` |  |
| upstream.server.ha.replicas | int | `1` |  |
| upstream.server.ha.apiAddr | string | `"https://vault.dev.bigbang.mil"` |  |
| upstream.server.ha.raft.enabled | bool | `true` |  |
| upstream.server.ha.raft.setNodeId | bool | `true` |  |
| upstream.server.statefulSet.securityContext.container.capabilities.drop[0] | string | `"ALL"` |  |
| upstream.ui.enabled | bool | `true` |  |
| upstream.csi.image.repository | string | `"registry1.dso.mil/ironbank/hashicorp/vault-csi-provider"` |  |
| upstream.csi.image.tag | string | `"v1.5.1"` |  |
| upstream.csi.resources.requests.cpu | string | `"50m"` |  |
| upstream.csi.resources.requests.memory | string | `"128Mi"` |  |
| upstream.csi.resources.limits.cpu | string | `"50m"` |  |
| upstream.csi.resources.limits.memory | string | `"128Mi"` |  |
| upstream.csi.daemonSet.securityContext.pod.runAsNonRoot | bool | `true` |  |
| upstream.csi.daemonSet.securityContext.pod.runAsGroup | int | `1000` |  |
| upstream.csi.daemonSet.securityContext.pod.runAsUser | int | `100` |  |
| upstream.csi.daemonSet.securityContext.pod.fsGroup | int | `1000` |  |
| upstream.csi.agent.image.repository | string | `"registry1.dso.mil/ironbank/hashicorp/vault"` |  |
| upstream.csi.agent.image.tag | string | `"1.20.3"` |  |
| upstream.csi.agent.resources.requests.memory | string | `"256Mi"` |  |
| upstream.csi.agent.resources.requests.cpu | string | `"250m"` |  |
| upstream.csi.agent.resources.limits.memory | string | `"256Mi"` |  |
| upstream.csi.agent.resources.limits.cpu | string | `"250m"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
