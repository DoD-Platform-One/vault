# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.29.1-bb.3] - 2025-01-15

### Changed

- Updated registry1.dso.mil/ironbank/hashicorp/vault/vault-k8s (source) v1.6.0 -> v1.6.1

## [0.29.1-bb.2] - 2024-12-19

### Changed

- Updated registry1.dso.mil/ironbank/hashicorp/vault (source) 1.18.2 -> 1.18.3

## [0.29.1-bb.1] - 2024-12-10

### Changed

- registry1.dso.mil/ironbank/hashicorp/vault/vault-k8s (source) v1.5.0 -> v1.6.0

## [0.29.1-bb.0] - 2024-12-04

### Changed

- Updated gluon 0.5.10 -> 0.5.12
- Updated registry1.dso.mil/ironbank/hashicorp/vault (source) 1.18.1 -> 1.18.2
- Updated minio-instance from 6.0.3-bb.2 -> 6.0.4-bb.2

## [0.29.0-bb.1] - 2024-12-04

### Changed

- Updated minio-instance from 6.0.4-bb.2 -> 6.0.4-bb.3
- Updated gluon to 0.5.12
- Added missing label for app.kubernetes.io/version

## [0.29.0-bb.0] - 2024-11-12

### Changed

- Updated charts to 0.29.0
- Updated minio-instance from 6.0.2-bb.2 -> 6.0.3-bb.2
- Updated gluon to 0.5.9
- Updated registry1.dso.mil/ironbank/hashicorp/vault/vault-k8s (source) v1.4.2 -> v1.5.0
- Added the maintenance track annotation and badge

## [0.28.1-bb.12] - 2024-11-06

### Changed

- Updated ironbank image to 1.18.1
- Updated gluon to 0.5.9

## [0.28.1-bb.11] - 2024-10-14

### Changed

- Updated ironbank image to 1.18.0

## [0.28.1-bb.9] - 2024-10-03

### Changed

- Removed hardcoded minio labels

## [0.28.1-bb.8] - 2024-09-27

### Changed

- Upgraded registry1.dso.mil/ironbank/hashicorp/vault 1.17.5 -> 1.17.6
- ironbank/hashicorp/vault 1.17.5-> 1.17.6

## [0.28.1-bb.7] - 2024-09-18

### Changed

- Updated minio-instance from 6.0.2-bb.2 -> 6.0.3-bb.2

## [0.28.1-bb.6] - 2024-09-12

### Changed

- Update Security Context for Secrets Store CSI Driver to comply with Kyverno policies

## [0.28.1-bb-5] - 2024-09-06

### Changed

- Reversed changes to cypress test

## [0.28.1-bb.4] - 2024-09-05

### Changed

- Gluon from 0.5.3 -> 0.5.4

## [0.28.1-bb.3] - 2024-09-04

### Changed

- Upgraded registry1.dso.mil/ironbank/hashicorp/vault 1.17.3 -> 1.17.5

## [0.28.1-bb.2] - 2024-08-27

### Updated

- Modified templating for `extraLabels` on `csi-daemonset.yaml`, `injector-deployment.yaml` and `server-statefulset.yaml` to use `tpl` to support passing kiali-required labels


## [0.28.1-bb.1] - 2024-08-21

### Changed

- ironbank/hashicorp/vault 1.14.10 -> 1.17.3
- Updated minio-instance 5.0.15-bb.2 -> 6.0.2-bb.2

## [0.28.1-bb.0] - 2024-08-12

### Changed

- Updated chart to v0.28.1
- registry1.dso.mil/ironbank/hashicorp/vault 1.15.3 -> 1.17.3
- registry1.dso.mil/ironbank/hashicorp/vault-csi-provider v1.4.3 -> 1.5.0
- Updated gluon version 0.5.2 -> 0.5.3

## [0.27.0-bb.1] - 2024-07-18

### Changed

- registry1.dso.mil/ironbank/hashicorp/vault 1.14.10 -> 1.15.3
- registry1.dso.mil/ironbank/hashicorp/vault/vault-k8s:v1.4.1 -> 1.4.2
- Updated gluon version 0.5.0 -> 0.5.2

## [0.27.0-bb.0] - 2024-07-18

### Changed

- registry1.dso.mil/ironbank/hashicorp/vault 1.14.10 -> 1.15.3
- added in (c) notices from upstream

## [0.25.0-bb.37] - 2024-06-25

### Changed

- Removed shared istio auth policies

## [0.25.0-bb.36] - 2024-07-10

### Changed

- Added documentation related to performing integration tests of sections of code and settings that have potential integration impacts

## [0.25.0-bb.38] - 2024-07-16

### Changed

- Removed duplicate entries in test-values.yaml compared with values.yaml

## [0.25.0-bb.37] - 2024-06-25

### Changed

- Removed shared istio auth policies

## [0.25.0-bb.36] - 2024-07-10

### Changed

- Added documentation related to performing integration tests of sections of code and settings that have potential integration impacts

## [0.25.0-bb.36] - 2024-07-11

### Changed

- Upgraded chart version

## [0.25.0-bb.35] - 2024-06-20

### Changed

- Add explicit weight to vault istio virtualservice destinations

## [0.25.0-bb.34] - 2024-06-18

### Added

- Updated cluster role resource to avoid naming conflict for OpenShift deployments

## [0.25.0-bb.33] - 2024-06-12

### Added

- Update cypress test

## [0.25.0-bb.32] - 2024-06-10

### Updated

- Updated minio-instance 5.0.12-bb.2 -> 5.0.15-bb.2

## [0.25.0-bb.31] - 2024-05-29

### Changed

- gluon 0.4.10 -> 0.5.0

## [0.25.0-bb.30] - 2024-05-21

### Added

- Update grafana dashboard to use `piechart`instead of broken `grafana-piechart-panel`

## [0.25.0-bb.29] - 2024-05-21

### Added

- gluon 0.4.9 -> 0.4.10
- registry1.dso.mil/ironbank/hashicorp/vault/vault-k8s v1.4.0 -> v1.4.1

## [0.25.0-bb.28] - 2024-05-08

### removed

- Sidecar to deny egress that is external to istio services
- customServiceEntries to allow egress to override sidecar

## [0.25.0-bb.27] - 2024-05-01

### Added

- Sidecar to deny egress that is external to istio services
- customServiceEntries to allow egress to override sidecar

## [0.25.0-bb.26] - 2024-04-26

### Added

- registry1.dso.mil/ironbank/hashicorp/vault-csi-provider v1.4.1 -> v1.4.2

## [0.25.0-bb.25] - 2024-04-25

### Changed

- Fixed bug with Prometheus datasource returning no data

## [0.25.0-bb.24] - 2024-04-24

### Removed

- Sidecar to deny egress that is external to istio services
- customServiceEntries to allow egress to override sidecar

## [0.25.0-bb.24] - 2024-04-24

### Removed

- Sidecar to deny egress that is external to istio services
- customServiceEntries to allow egress to override sidecar

## [0.25.0-bb.23] - 2024-04-09

### Added

- Added the ability to deploy additional custom NetworkPolicy objects via override values (see chart/templates/bigbang/additional-networkpolicies.yaml)

## [0.25.0-bb.22] - 2024-03-09

### Changed

- Updated to gluon to 4.9

## [0.25.0-bb.21] - 2024-03-19

### changed

- Adding Sidecar to deny egress that is external to istio services
- Adding customServiceEntries to allow egress to override sidecar

## [0.25.0-bb.20] - 2024-03-15

### Updated

- Updated registry1.dso.mil/ironbank/hashicorp/vault/vault-k8s 1.3.1 -> v1.4.0

## [0.25.0-bb.19] - 2024-03-13

### Updated

- Added value for openshift defaulting to false in values.yaml

## [0.25.0-bb.18] - 2024-03-11

### Updated

- Updated registry1.dso.mil/ironbank/hashicorp/vault 1.14.9 -> 1.14.10

## [0.25.0-bb.17] - 2024-03-04

### Changed

- Openshift update for deploying Vault into Openshift cluster

## [0.25.0-bb.16] - 2024-03-04

### Changed

- Updated minio-instance to 5.0.12-bb.2

## [0.25.0-bb.15] - 2024-02-22

### Changed

- Updated to gluon to 4.8

## [0.25.0-bb.14] - 2024-02-05

### Updated

- renamed allow-api-access policy

## [0.25.0-bb.13] - 2024-02-02

### Updated

- allow-api-access policy

## [0.25.0-bb.12] - 2024-02-02

### Updated

- Updated registry1.dso.mil/ironbank/hashicorp/vault 1.14.8 -> 1.14.9

## [0.25.0-bb.11] - 2024-01-18

### Updated

- allow-intranamespace policy
- allow-nothing-policy
- ingressgateway-authz-policy
- monitoring-authz-policy
- promtail-authz-policy
- template for adding user defined policies
- enabling hardening during testing

## [0.25.0-bb.10] - 2023-11-21

### Updated

- Updated registry1.dso.mil/ironbank/hashicorp/vault 1.14.6 -> 1.14.8

## [0.25.0-bb.9] - 2024-01-17

### Changed

- Updated to gluon to 4.7 allowing consumers to implement custom scripts
- Updated Minio to 5.0.11-bb.2

## [0.25.0-bb.8] - 2023-12-28

### Changed

- Updated `values.yaml` to configure Vault TLS configuration based on `global.tlsDiable`, `istio.vault.tls.key`, and `istio.vault.tls.cert`
- Updated Developer Documentation to provide guidance for configuring Vault with a `PASSTHROUGH` istio gateway

## [0.25.0-bb.7] - 2023-12-14

### Changed

- Increased Cypress test resources

## [0.25.0-bb.6] - 2023-12-12

### Changed

- Updated gluon 0.4.4 -> 0.4.5

## [0.25.0-bb.5] - 2023-11-21

### Updated

- Updated registry1.dso.mil/ironbank/hashicorp/vault 1.14.2 -> 1.14.6
- Updated registry1.dso.mil/ironbank/hashicorp/vault/vault-k8s 1.3.0 -> 1.3.1
- Updated gluon 0.4.1 -> 0.4.4
- Updated minio-instance 5.0.9-bb.2 -> 5.0.10-bb.2
- Updated registry1.dso.mil/ironbank/big-bang/base 2.0.0 -> 2.1.0

## [0.25.0-bb.4] - 2023-10-11

### Updated

- Updated OSCAL version from 1.0.0 to 1.1.1

## [0.25.0-bb.3] - 2023-10-03

### Changed

- Added resiliency to auto unseal job

## [0.25.0-bb.2] - 2023-10-02

### Changed

- Updated minio-instance 5.0.3-bb.2 -> 5.0.9-bb.2

## [0.25.0-bb.1] - 2023-09-19

### Changed

- Updated registry1.dso.mil/ironbank/hashicorp/vault/vault-k8s 1.2.1 -> 1.3.0
- Updated gluon 0.4.0 -> 0.4.1
- Updated Cypress files

## [0.25.0-bb.0] - 2023-09-12

### Changed

- Updated registry1.dso.mil/ironbank/hashicorp/vault 1.13.1 -> 1.14.2
- Updated minio-instance 4.5.4-bb.2 -> 5.0.3-bb.2
- Updated gluon 0.3.2 -> 0.4.0

## [0.24.1-bb.3] - 2023-08-18

### Changed

- Adding proxyMetadata to Vault init job

## [0.24.1-bb.2] - 2023-08-15

### Changed

- Adding service entry for Vault and monitoring to connect to Vault

## [0.24.1-bb.1] - 2023-05-30

### Changed

- Fix VAULT_ADDR in autoInit job configMap

## [0.24.1-bb.0] - 2023-05-08

### Changed

- `vault` updated to 1.13.1
- `vault-k8s` updated to 1.2.1
- `vault-csi-provider` updated to v1.4.0

## [0.23.0-bb.5] - 2023-04-19

### Changed

- `vault-csi-provider` updated to v1.3.0

## [0.23.0-bb.4] - 2023-04-04

### Changed

- `vault` updated to 1.12.5
- `vault-k8s` updated to 1.2.0

## [0.23.0-bb.3] - 2022-03-22

### Changed

- `vault` updated to 1.12.4

## [0.23.0-bb.2] - 2022-01-18

### Changed

- remove bogus leader-elector image from values
- change vault-csi-provider image to Iron Bank image

## [0.23.0-bb.1] - 2022-01-17

### Changed

- Update gluon to new registry1 location + latest version (0.3.2)

## [0.23.0-bb.0] - 2022-12-28

### Updated

- `vault` updated to 1.12.1 [GH-814](https://github.com/hashicorp/vault-helm/pull/814)
- `vault-k8s` updated to 1.1.0 [GH-814](https://github.com/hashicorp/vault-helm/pull/814)
- `vault-csi-provider` updated to 1.2.1 [GH-814](https://github.com/hashicorp/vault-helm/pull/814)

## [0.22.1-bb.3] - 2022-12-19

### Updated

- Migrated minio dep to OCI repository

## [0.22.1-bb.2] - 2022-12-02

### Updated

- Update Vault to appVersion `1.12.1` , `vault-k8s` to `1.1.0`
- Updated gluon to `0.3.1`
- update Minio dependency to `4.5.4-bb.2`

## [0.22.1-bb.1] - 2022-11-16

### Updated

- Fixed security context capability violations

## [0.22.1-bb.0] - 2022-11-22

### Updated

- Update Vault to appVersion `1.12.0` helm chart version `0.22.1` , `vault-k8s` to `1.0.1`
- Updated gluon to `0.3.1`
- update Minio dependency to `4.5.4-bb.0`

## [0.22.0-bb.4] - 2022-11-14

### Updated

- Updated minio dependency chart to `4.5.3-bb.1`

## [0.22.0-bb.3] - 2022-10-07

### Removed

- Removed metric monitoring exception for Istio PeerAuthentication resource

## [0.22.0-bb.2] - 2022-09-28

### Updated

- Enhance Renovate functionality

## [0.22.0-bb.1] - 2022-09-28

### Added

- Added `oscal-component.yaml` file to project root w/ implemented requirements against NIST 800-53

## [0.22.0-bb.0] - 2022-09-21

### Updated

- Update Vault to appVersion `1.11.3` helm chart version `0.22.0` , `vault-k8s` to `1.0.0`

## [0.21.0-bb.0] - 2022-08-12

### Updated

- Updated `vault` to `1.11.2`, `vault-k8s` to `0.17.0`

## [0.20.1-bb.4] - 2022-07-11

### Changed

- Added configurable PVC size for dev/testing

## [0.20.1-bb.3] - 2022-07-07

### Updated

- Updated vault to v1.11.0 and minio to 4.4.16-bb.0

## [0.20.1-bb.2] - 2022-06-28

### Changed

- Updated bb base image to 2.0.0
- Updated gluon to 0.2.10

## [0.20.1-bb.1] - 2022-06-27

### Added

- added PeerAuthentication for autoInit job

## [0.20.1-bb.0] - 2022-06-06

### Updated

- Updated `vault-k8s` to `1.16.1`, `big-bang/base` to `1.17.0`
- Fixed `vault-plugin-secrets-oauthapp` link

## [0.20.0-bb.2] - 2022-06-03

### Updated

- Add mTLS PeerAuthentication policy

## [0.20.0-bb.1] - 2022-05-23

### Updated

- enable use of passthrough ingress gateway for CI pipeline
- Allow autoInit job to work with HA and passthrough TLS

## [0.20.0-bb.0] - 2022-05-17

### Updated

- Updated vault to 1.10.3 and big-bang/base to 1.16.0
- update to appVersion 1.10.3 chart version 0.20.0

## [0.19.0-bb.9] - 2022-05-09

### Updated

- Updated vault to 1.10.1 and big-bang/base to 1.2.0

## [0.19.0-bb.8] - 2022-04-18

### Updated

- Update Ironbank Docker tags: `vault` to `1.10.0` and `vault-k8s` to `0.15.0`
- Updated appVersion to `1.10.0`

## [0.19.0-bb.7] - 2022-04-11

### Added

- Added production/operational documentation
- Add vault-tls secret template for passthrough ingress gateway

## [0.19.0-bb.6] - 2022-03-29

### Added

- Added Tempo Zipkin Egress Policy

## [0.19.0-bb.5] - 2022-03-17

### Added

- Hashicorp prometheus chart
- PROMETHEUS.md

### Changed

- Changes to chart/templates/bigbang/autoUnsealAndInit/configmap-for-vault-init.yaml for creating vault resources

## [0.19.0-bb.4] - 2022-03-10

### Updated

- Update vault version to 1.9.4

## [0.19.0-bb.3] - 2022-03-10

### Changed

- Create documentation for SSO integration

## [0.19.0-bb.2] - 2022-03-01

### Changed

- Deleted upstream helm test to prevent BB CI failure

## [0.19.0-bb.1] - 2022-02-28

### Updated

- Update minio dependency chart to 4.4.10-bb.0

## [0.19.0-bb.0] - 2022-02-25

### Updated

- kpt updated helm chart to v0.19.0

## [0.18.0-bb.8] - 2022-02-21

### Updated

- Update vault version to 1.9.3

## [0.18.0-bb.7] - 2022-02-16

### Updated

- Update mino dependency chart to 4.4.3-bb.3

## [0.18.0-bb.6] - 2022-02-03

### Updated

- Update mino dependency chart to 4.4.3-bb.2

## [0.18.0-bb.5] - 2022-01-31

### Changed

- Update Chart.yaml to follow new standardization for release automation

## [0.18.0-bb.4] - 2022-01-10

### Changed

- Changed egress-metadata.yaml to only deploy on condition the server config contains "awskms"

## [0.18.0-bb.3] - 2021-12-21

### Changed

- Changed egress-vault networkpolicy to not check for `networkPolicies.controlPlaneCidr` but new value `networkPolicies.vpcCidr`

## [0.18.0-bb.2] - 2021-12-15

### Changed

- Changed network policies to be more restrictive

## [0.18.0-bb.1] - 2021-12-13

### Added

- Networkpolicy to allow ingress for service calls and agent-injector
- Store full output of the initial vault init in the vault-token secret
- More documentation for bigbang and vault

## [0.18.0-bb.0] - 2021-12-10

### Changed

- Update vault upstream chart

## [0.16.1-bb.3] - 2021-12-7

### Changed

- Added conditional to run autoinit job only on install
- Changed affinity to `preferredDuringScheduling` in test values for CI package pipeline

## [0.16.1-bb.2] - 2021-11-29

### Added

- Security context for init job

## [0.16.1-bb.1] - 2021-11-15

### Changed

- Vault images for job and agent match
- Resources and Requests match for Guaranteed QoS

## [0.16.1-bb.0] - 2021-08-27

### Changed

- Vault helm chart added and configured to work with other BigBang apps, libraries and pipelines
