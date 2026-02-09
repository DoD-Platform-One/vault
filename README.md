<!-- Warning: Do not manually edit this file. See notes on gluon + helm-docs at the end of this file for more information. -->
# vault

![Version: 0.31.0-bb.9](https://img.shields.io/badge/Version-0.31.0--bb.9-informational?style=flat-square) ![AppVersion: 1.21.1](https://img.shields.io/badge/AppVersion-1.21.1-informational?style=flat-square) ![Maintenance Track: bb_integrated](https://img.shields.io/badge/Maintenance_Track-bb_integrated-green?style=flat-square)

Official HashiCorp Vault Chart

## Upstream References

- <https://developer.hashicorp.com/vault>
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
| domain | string | `"dev.bigbang.mil"` |  |
| monitoring.enabled | bool | `false` |  |
| monitoring.namespace | string | `"monitoring"` |  |
| routes.inbound.vault.enabled | bool | `true` |  |
| routes.inbound.vault.gateways[0] | string | `"istio-gateway/passthrough-ingressgateway"` |  |
| routes.inbound.vault.hosts[0] | string | `"vault.{{ .Values.domain }}"` |  |
| routes.inbound.vault.service | string | `"vault-vault.vault.svc.cluster.local"` |  |
| routes.inbound.vault.port | int | `8200` |  |
| routes.inbound.vault.passthrough.enabled | bool | `true` |  |
| istio.enabled | bool | `false` |  |
| istio.sidecar.enabled | bool | `false` |  |
| istio.sidecar.outboundTrafficPolicyMode | string | `"REGISTRY_ONLY"` |  |
| istio.serviceEntries.custom | list | `[]` |  |
| istio.authorizationPolicies.enabled | bool | `false` |  |
| istio.authorizationPolicies.custom | list | `[]` |  |
| istio.mtls.mode | string | `"STRICT"` |  |
| tls.cert | string | `""` |  |
| tls.key | string | `""` |  |
| networkPolicies.enabled | bool | `false` |  |
| networkPolicies.ingress.definitions.custom-app-ingress.from[0].namespaceSelector | object | `{}` |  |
| networkPolicies.ingress.definitions.custom-app-ingress.from[0].podSelector.matchLabels.vault-ingress | string | `"true"` |  |
| networkPolicies.ingress.to.vault:8200.from.k8s.monitoring-monitoring-kube-prometheus@monitoring/prometheus | bool | `false` |  |
| networkPolicies.ingress.to.vault:8200.from.definition.custom-app-ingress | bool | `true` |  |
| networkPolicies.ingress.to.vault-agent-injector:8080.from.cidr."0.0.0.0/0" | bool | `true` |  |
| networkPolicies.egress.definitions.kms.to[0].ipBlock.cidr | string | `"0.0.0.0/0"` |  |
| networkPolicies.egress.definitions.kms.ports[0].port | int | `443` |  |
| networkPolicies.egress.definitions.kms.ports[0].protocol | string | `"TCP"` |  |
| networkPolicies.egress.from.vault.to.cidr."169.254.169.254/32" | bool | `true` |  |
| networkPolicies.egress.from.vault.to.k8s.tempo/tempo:9411 | bool | `false` |  |
| networkPolicies.egress.from.vault.to.definition.kms | bool | `true` |  |
| networkPolicies.egress.from.vault.to.definition.kubeAPI | bool | `true` |  |
| networkPolicies.egress.from.vault-agent-injector.to.definition.kubeAPI | bool | `true` |  |
| networkPolicies.egress.from.vault-autoinit.podSelector.matchLabels."batch.kubernetes.io/job-name" | string | `"vault-vault-job-init"` |  |
| networkPolicies.egress.from.vault-autoinit.to.definition.kubeAPI | bool | `true` |  |
| networkPolicies.additionalPolicies | list | `[]` |  |
| autoInit.enabled | bool | `true` |  |
| autoInit.image.repository | string | `"registry1.dso.mil/ironbank/big-bang/base"` |  |
| autoInit.image.tag | string | `"2.1.0"` |  |
| autoInit.storage.size | string | `"2Gi"` |  |
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
| upstream | object | Upstream chart values | Values to pass to [the upstream vault chart](https://github.com/hashicorp/vault-helm/blob/main/values.yaml) |

## Contributing

Please see the [contributing guide](./CONTRIBUTING.md) if you are interested in contributing.

---

_This file is programatically generated using `helm-docs` and some BigBang-specific templates. The `gluon` repository has [instructions for regenerating package READMEs](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)._

