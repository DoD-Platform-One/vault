# How to upgrade the Vault Package chart

1. Checkout the branch that renovate created. This branch will have the image tag updates and typically some other necessary version changes that you will want. You can either work off of this branch or branch off of it.
2. To update vault's helm chart visit the upstream to see if there is a new release: https://github.com/hashicorp/vault-helm/blob/main/values.yaml. Locate dependencies within chart/chart.yaml and update. Whenever a dependency is updated you need to run `helm dependencies update ./chart` to pull in the new chart. Make sure the old helm chart has been removed and the new one has been added within chart/charts.
3. Update version references for the Chart in chart/Chart.yaml. versionshould be-bb.0(ex:1.14.3-bb.0) and appVersionshould be(ex:1.14.3). Also validate that the BB annotation for the main Istio version is updated (leave the Tetrate version as-is unless you are updating those images).
4. Verify that chart/values.yaml tag have been updated to the new version.
5. Add a changelog entry for the update. At minimum mention updating the image versions.
6. Update the readme following the [steps in Gluon.](https://repo1.dso.mil/big-bang/product/packages/gluon/-/blob/master/docs/bb-package-readme.md)
7. Open MR (or check the one that Renovate created for you) and validate that the pipeline is successful. Also follow the testing steps below for some manual confirmations.

# Testing new Vault version

## Branch/Tag Config

If you'd like to install from a specific branch or tag, then the code block under vault needs to be uncommented and used to target your changes.
For example, this would target the renovate/ironbank branch.

```
addons:
  vault:
    enabled: true
    git:
      repo: https://repo1.dso.mil/big-bang/product/packages/vault.git
      path: chart
      tag: null # make sure to set tag to null
      branch: "renovate/ironbank" # update this branch with your target branch.
```

## Cluster setup
Always make sure your local bigbang repo is current before deploying.
1. Export your Ironbank/Harbor credentials (this can be done in your ~/.bashrc or ~/.zshrc file if desired). These specific variables are expected by the k3d-dev.sh script when deploying metallb, and are referenced in other commands for consistency:

```
export REGISTRY_USERNAME='<your_username>'
export REGISTRY_PASSWORD='<your_password>'
```
2. Export the path to your local bigbang repo (without a trailing /):

Note that wrapping your file path in quotes when exporting will break expansion of ~.

```
export BIGBANG_REPO_DIR=<absolute_path_to_local_bigbang_repo>
```
e.g.

```
export BIGBANG_REPO_DIR=~/repos/bigbang
```
3. Run the k3d_dev.sh script to deploy a dev cluster (-a flag required if deploying a local Keycloak):

```
"${BIGBANG_REPO_DIR}/docs/assets/scripts/developer/k3d-dev.sh"
```

For local keycloak.dev.bigbang.mil Keycloak (-a deploys instance with a second public IP and metallb):

```
"${BIGBANG_REPO_DIR}/docs/assets/scripts/developer/k3d-dev.sh -a"
```

4. Export your kubeconfig:

```
export KUBECONFIG=~/.kube/<your_kubeconfig_file>
```

e.g.

```
export KUBECONFIG=~/.kube/Sam.Sarnowski-dev-config
```
5. [Deploy flux to your cluster:](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/scripts/install_flux.sh)

```
"${BIGBANG_REPO_DIR}/scripts/install_flux.sh -u ${REGISTRY_USERNAME} -p ${REGISTRY_PASSWORD}"
```
## Deploy Bigbang

From the root of this repo, run one of the following deploy commands depending on which Keycloak you wish to reference:
For login.dso.mil Keycloak:

```
helm upgrade -i bigbang ${BIGBANG_REPO_DIR}/chart/ -n bigbang --create-namespace \
--set registryCredentials.username=${REGISTRY_USERNAME} --set registryCredentials.password=${REGISTRY_PASSWORD} \
-f https://repo1.dso.mil/big-bang/bigbang/-/raw/master/tests/test-values.yaml \
-f https://repo1.dso.mil/big-bang/bigbang/-/raw/master/chart/ingress-certs.yaml \
-f https://repo1.dso.mil/big-bang/bigbang/-/raw/master/docs/assets/configs/example/dev-sso-values.yaml \
-f docs/dev-overrides/minimal.yaml \
-f docs/dev-overrides/vault-testing.yaml
```
## Test Values Yaml

As part of your MR that modifies bigbang packages, you should modify the bigbang [bigbang/tests/test-values.yaml](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/tests/test-values.yaml?ref_type=heads) against your branch for the CI/CD MR testing by enabling your packages.

## Validation/Testing Steps

1. Browse to [vault dev](https://vault.dev.bigbang.mil)

2. Set Method to Token and log in. To get the token, run:
```kubectl get secret -n vault vault-token -o go-template='{{.data.key | base64decode}}'```
3. Once you've logged in, choose Tools from the left-hand column. 
4. Now choose Random from the left-hand column. Click Generate to generate a random 32 byte base64 value. Copy this value to your clipboard. 
5. Click "back to main navigation." Under Secrets Engines on the main page, you should see the cubbyhole secrets engine. Click on it. 
6. Click Create Secret
7. Under "Path for this secret" enter ~
8. Under "Secret data" enter test01 for your secret and for the secret data, paste in the random base64 value you generated above. 
9. Click Save. Confirm that you see your secret listed.
10. In the left-hand column, click Policies. You should see these policies listed: default, prometheus-metrics, and root. 

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
## chart/tests/*
- add cypress tests
## chart/Chart.yaml
- version/appVersion
- add gluon dependency
- Update bigbang.dev/applicationVersions
## chart/values.yaml
- BigBang additions lines [1010-1055](https://repo1.dso.mil/platform-one/big-bang/apps/sandbox/vault/-/blob/renovate/ironbank/chart/values.yaml#L1010-1055)
- BigBang edited lines [789-795,881-887,921-927](https://repo1.dso.mil/big-bang/product/packages/vault/-/merge_requests/115/diffs#679c9c413d4749f4bd9d593879d89e405b2e471e_789_789)

### automountServiceAccountToken
The mutating Kyverno policy named `update-automountserviceaccounttokens` is leveraged to harden all ServiceAccounts in this package with `automountServiceAccountToken: false`. This policy is configured by namespace in the Big Bang umbrella chart repository at [chart/templates/kyverno-policies/values.yaml](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/chart/templates/kyverno-policies/values.yaml?ref_type=heads).

This policy revokes access to the K8s API for Pods utilizing said ServiceAccounts. If a Pod truly requires access to the K8s API (for app functionality), the Pod is added to the `pods:` array of the same mutating policy. This grants the Pod access to the API, and creates a Kyverno PolicyException to prevent an alert.

# Files that need integration testing

If you modify any of these things, you should perform an integration test with your branch against the rest of bigbang. Some of these files have automatic tests already defined, but those automatic tests may not model corner cases found in full integration scenarios.

* `./chart/templates/prometheus-*`
* `./chart/templates/bigbang/istio`
* `./chart/templates/bigbang/networkpolicies`
* `./chart/templates/bigbang/vault-*`
* `./chart/templates/autoUnsealAndInit`
* `./chart/templates/bigbang/networkPolicies`
* `./chart/templates/bigbang/gitlab-grafana-dashboards.yaml`
* `./chart/templates/server-network-policy.yaml`
* `./chart/templates/server-ingress.yaml`
* `./chart/templates/injector-mutating-webhook.yaml`
* `./chart/templates/injector-network-policy.yaml`
* `./chart/templates/injector-clusterrole*`
* `./chart/values.yaml` if it involves any of:
  * monitoring changes
  * network policy changes
  * kyverno policy changes
  * istio hardening rule changes
  * service definition changes
  * TLS settings
  * vault mutating webhook settings
  * server ingress settings
  * headless server settings (especially port or other comms settings)

Follow [the standard process](https://repo1.dso.mil/big-bang/bigbang/-/blob/master/docs/developer/test-package-against-bb.md?ref_type=heads) for performing an integration test against bigbang.