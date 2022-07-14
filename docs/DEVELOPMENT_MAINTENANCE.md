# How to upgrade the Vault Package chart

1. Sync with upstream chart. This can be done with kpt or meld:
```
kpt pkg update chart/@{TAG} --strategy alpha-git-patch
```
or
```
kpt pkg update chart/@{TAG} --strategy force-delete-replace
```
or

[Meld UI](https://meldmerge.org/)

BigBang makes modifications to the upstream helm chart. The full list of changes is at the end of  this document.  

# Testing new Vault version
1. Create a k8s dev environment. One option is to use the Big Bang [k3d-dev.sh](https://repo1.dso.mil/platform-one/big-bang/bigbang/-/tree/master/docs/developer/scripts) with no arguments which will give you the default configuration. The following steps assume you are using the script.
1. Follow the instructions at the end of the script to connect to the k8s cluster and install flux.
1. Deploy Vault with these dev values overrides. Core apps are disabled for quick deployment.
```
    domain: bigbang.dev

    flux:
      interval: 1m
      rollback:
        cleanupOnFail: false

    networkPolicies:
      enabled: true

    istio:
      enabled: true

    istiooperator:
      enabled: true

    jaeger:
      enabled: false

    kiali:
      enabled: false

    clusterAuditor:
      enabled: false

    gatekeeper:
      enabled: false

    logging:
      enabled: false

    eckoperator:
      enabled: false

    fluentbit:
      enabled: false

    monitoring:
      enabled: false

    twistlock:
      enabled: false

    sso:
      oidc:
        host: login.dso.mil
        realm: baby-yoda
      client_secret: ""

    addons:
      vault:
        enabled: true
        values: 
          autoInit:
            enabled: true 
```            

# Modifications made to upstream chart
This is a high-level list of modifitations that Big Bang has made to the upstream helm chart. You can use this as as cross-check to make sure that no modifications were lost during the upgrade process.

## chart/charts/*   
- sub-charts generated with `helm dependency update`
## chart/dashboards/*
- Grafana dashboard support
## chart/deps/*
- add MinIO and `helm dependency update`
## chart/templates/bigbang/*
- add templates to support Big Bang integration
## chart/templates/tests/*
- delete server-test.yaml
## chart/tests/*
- add cypress tests
## chart/Chart.yaml
- version/appVersion
- add gluon dependency
- Update bigbang.dev/applicationVersions
## chart/values.yaml
- BigBang additions lines [1010-1055](https://repo1.dso.mil/platform-one/big-bang/apps/sandbox/vault/-/blob/renovate/ironbank/chart/values.yaml#L1010-1055)
