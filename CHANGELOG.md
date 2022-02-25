# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
