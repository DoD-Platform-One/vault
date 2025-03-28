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
1. Create a k8s dev environment. One option is to use the Big Bang [k3d-dev.sh](https://repo1.dso.mil/platform-one/big-bang/bigbang/-/tree/master/docs/developer/scripts) with no arguments which will give you the default configuration. The following steps assume you are using the script. NOTE: you will need to run it with `-m` and once it's done setup sshuttle and your hosts file.
1. Follow the instructions at the end of the script to connect to the k8s cluster and install flux.
1. Deploy Vault with these dev values overrides. Core apps are disabled for quick deployment.
1. Kyverno blocks PVC provisioning on k3d by default because they are local path, need to add the dev exception(s)
```yaml
domain: bigbang.dev

flux:
  interval: 1m
  rollback:
    cleanupOnFail: false

networkPolicies:
  enabled: true

jaeger:
  enabled: false

kiali:
  enabled: false

clusterAuditor:
  enabled: false

gatekeeper:
  enabled: false

fluentbit:
  enabled: false

monitoring:
  enabled: false

twistlock:
  enabled: false

istio:
  ingressGateways:
    passthrough-ingressgateway:
      type: "LoadBalancer"
  gateways:
    passthrough:
      ingressGateways: "passthrough-ingressgateway"
      hosts:
      - "vault.dev.bigbang.mil"
      tls:
        mode: "PASSTHROUGH"

kyvernoPolicies:
  enabled: true
  values:
      exclude:
        any:
          # Allows k3d load balancer to bypass policies.
          - resources:
              namespaces:
              - istio-system
              - vault
              names:
              - svclb-*
        policies:
          restrict-host-path-mount-pv:
            parameters:
              allow:
              - /var/lib/rancher/k3s/storage/pvc-*

addons:
  vault:
    enabled: true
    git:
      repo: https://repo1.dso.mil/big-bang/product/packages/vault.git
      path: chart
      tag: null
      # tag: 6.3.4
      branch: "57-implement-istio-authorization-policies"
      # existingSecret: ""
      # credentials:
      #   password: ""
      #   username: ""

    values:
      istio:
        enabled: true
        hardened:
          enabled: true
          # enabled: false

      global:
        tlsDisable: false

    ingress:
      gateway: passthrough
      key: |
        -----BEGIN PRIVATE KEY-----
        MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC9eqdce6kUk/Iq
        CXf2AA0Xd/wOAoxGjhJbcCu4Ckl86wsXiV9aMyCVucPxbI84x1Ahv2xX9CY6WKRf
        kVn9TBIaADUDvIWPZ6A/dV7CcdsYpU8XrQ7dPV/PC2L90WePz8ZlggLG8vEkSFNc
        WEDLvFsQQiVEhQRmGfiPtATbZh/an4aNsSsaHLU4dA+Fk4Dcr3T2Ng+2ssHcezsY
        gqBS//VHr02AbZ3ULYoq1uHeVSiaPa0JSfo4cBPMTH3UXWgC8LJZtJ3PI8BVRAcx
        w4igwwE2mQf0ac7XFaxk3QS6Nfiw2Nycyqj/EHYe9sjYAS22uF4FBehadT1+sFd1
        Ipss0CM/AgMBAAECggEAZIspM9IKrnizD8tmdIsiZ0mr3mNLvES3SP4EtOwAguDW
        Se8DQgHPUKP6bamFdkONKdtByoorntpanruqXNZ45IMnnovy812xkvrdBaEU+cb+
        aTnToWJn7J3GMZlkstM2G7cZciiH/RDD60SJXZLdX4s561oKM4Okedy0lxdh38fL
        5OzMAQkrTEqDLRUbpLK1Q6tqUTQ5+dfvr8CFeDSVp9IO9X+iaWIaG/qDcncb2273
        3Hl97inXZpLE2js1izw3gk01EbPIC3deuDYus/Bi2S4MQEmJc83N+jEVp/Bg/NO2
        8XwzytR19MBQ2OdLPcE/Sc2x63uZMTt4m/4969F5gQKBgQDzHtxjo2xuR6o9DWu0
        wM9xq+qr+udzF/iWYjwdSkpV0iI8AddoZ0EbqswWdXeyk6D3uduV2cJ3tnWRiuIh
        07D+NBdLeWS985RA8NSpIJxswU+Y0O1TiB7e3tEQnxbdcG5fyH+ChpxpuRog5ppJ
        zDOATFk7M3NXOa4Qr/l2SGqQ1wKBgQDHhFJE+gloDl4sSAoNScNvqXUog5BVjed0
        MB6puF3kCPUyavyA24wARR3wPSYlJkZZeTvnlPo+vV53HZtuLuHtwOA6BVp4HFEt
        2KjcAqkIZ0OfcQ/usiRuLcaUsdap2Qb+HbUsqUWx/bI2kYapOSoi9Hil5mwLv2jK
        3fZdperr2QKBgQCqqc5Br3WtUGdjpikmYHb+r5TzlxSkCX66akkSspTN+82GXDCP
        HHRq7JGJbnpRBCrp2zEW1x8ZFB8hxOGKp2TGfWCg3Z1nbjZzA9v0wWytN2IdvwPq
        MFKjVrxhs5vEZGlGmaNQyBfCa2q5D8fc6Bh7Bp1Y3nwoDdhv5Gf0rU8JTwKBgCBo
        MMi9aEu7kbZVmTRhV9pKRxpmjEopO4AW1NQyeyWwAsvGru7rOklM8Lj15b1BA0pD
        M+TAwQjxz2c/quBxwwbQPluORQyfZNwyhfL+h6AyzbwXLERUMTCoRMogPMLn2ofq
        IWR4tjZcA9dzOdFA1MRKu1IPJFugIpBZD0xUx9y5AoGASqQ8II+NBuGrLmQ2/rP9
        uZaz/eL1/RH2PkarXKuKZaFmdgjkLjypcfCACH7w6SG4Teu2ILjvN0QlD+anJvak
        0FQLeul4UVJmuBAxjOd/LtfCjBXJ7+tZE0sbE/GrcAinrFhJS/IePRkDgkPLdJNc
        RoAiPeI18BpEhHTApeV8cnk=
        -----END PRIVATE KEY-----
      cert: |
        -----BEGIN CERTIFICATE-----
        MIIE5jCCA86gAwIBAgISA8hjRz2sIa8zW1sJHdgG0lnbMA0GCSqGSIb3DQEBCwUA
        MDIxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MQswCQYDVQQD
        EwJSMzAeFw0yMzExMTQxMzUxNDRaFw0yNDAyMTIxMzUxNDNaMBgxFjAUBgNVBAMM
        DSouYmlnYmFuZy5kZXYwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC9
        eqdce6kUk/IqCXf2AA0Xd/wOAoxGjhJbcCu4Ckl86wsXiV9aMyCVucPxbI84x1Ah
        v2xX9CY6WKRfkVn9TBIaADUDvIWPZ6A/dV7CcdsYpU8XrQ7dPV/PC2L90WePz8Zl
        ggLG8vEkSFNcWEDLvFsQQiVEhQRmGfiPtATbZh/an4aNsSsaHLU4dA+Fk4Dcr3T2
        Ng+2ssHcezsYgqBS//VHr02AbZ3ULYoq1uHeVSiaPa0JSfo4cBPMTH3UXWgC8LJZ
        tJ3PI8BVRAcxw4igwwE2mQf0ac7XFaxk3QS6Nfiw2Nycyqj/EHYe9sjYAS22uF4F
        BehadT1+sFd1Ipss0CM/AgMBAAGjggIOMIICCjAOBgNVHQ8BAf8EBAMCBaAwHQYD
        VR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMAwGA1UdEwEB/wQCMAAwHQYDVR0O
        BBYEFL4y4ZOmWpKoXHZDc58Pnuqix5X8MB8GA1UdIwQYMBaAFBQusxe3WFbLrlAJ
        QOYfr52LFMLGMFUGCCsGAQUFBwEBBEkwRzAhBggrBgEFBQcwAYYVaHR0cDovL3Iz
        Lm8ubGVuY3Iub3JnMCIGCCsGAQUFBzAChhZodHRwOi8vcjMuaS5sZW5jci5vcmcv
        MBgGA1UdEQQRMA+CDSouYmlnYmFuZy5kZXYwEwYDVR0gBAwwCjAIBgZngQwBAgEw
        ggEDBgorBgEEAdZ5AgQCBIH0BIHxAO8AdgBIsONr2qZHNA/lagL6nTDrHFIBy1bd
        LIHZu7+rOdiEcwAAAYvOUR0aAAAEAwBHMEUCIHR8IW3SQNSUC4Zia1bvBugYqJWm
        bKdMHHlC6jHL0haVAiEAlgfBYXNUzp/7sRBzPG1uLJCcCOst/7UMc7NqCxrdwXMA
        dQB2/4g/Crb7lVHCYcz1h7o0tKTNuyncaEIKn+ZnTFo6dAAAAYvOUR2KAAAEAwBG
        MEQCIE02snNREt4rXycxXWFzhFjduxPLVXVUtsl56KO8fdfbAiA8fKX5IkjvXBVl
        XBklYqaxtnIoeKjjG8HuX8hnDdz3xzANBgkqhkiG9w0BAQsFAAOCAQEAXXNR7dcb
        MU/KPa/oDApnrTes2u72zFP8e8nGclLz3OMHctLTVa9Gb6men+oi2qLP8+Sd8F9/
        fxWA3Ut5lAkwsFRdcJ03ZD3XOu4YlS8s/5kHotY0NsOtQfMOiZb/A1aIDPwkPmAK
        Z4/Kxj952GXnVkacpZKJn17ew/JbKglENmdHCAQMTH1Mnk/hexpdPwDVV/fky1WO
        UVmwnF1y1XficNPH8HuNZza6cUSEpnJ+37og/uh3Y2jXPdjyWOGMi0tHoxJE2Yi9
        xMkMy39lj+vdXgio/oX+Sr7pxqMwXjGYdVVSikUmqtefGGsm5TywQxUFGji/HVeh
        qw1Sdc4+BMLiZQ==
        -----END CERTIFICATE-----
        -----BEGIN CERTIFICATE-----
        MIIFFjCCAv6gAwIBAgIRAJErCErPDBinU/bWLiWnX1owDQYJKoZIhvcNAQELBQAw
        TzELMAkGA1UEBhMCVVMxKTAnBgNVBAoTIEludGVybmV0IFNlY3VyaXR5IFJlc2Vh
        cmNoIEdyb3VwMRUwEwYDVQQDEwxJU1JHIFJvb3QgWDEwHhcNMjAwOTA0MDAwMDAw
        WhcNMjUwOTE1MTYwMDAwWjAyMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNTGV0J3Mg
        RW5jcnlwdDELMAkGA1UEAxMCUjMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
        AoIBAQC7AhUozPaglNMPEuyNVZLD+ILxmaZ6QoinXSaqtSu5xUyxr45r+XXIo9cP
        R5QUVTVXjJ6oojkZ9YI8QqlObvU7wy7bjcCwXPNZOOftz2nwWgsbvsCUJCWH+jdx
        sxPnHKzhm+/b5DtFUkWWqcFTzjTIUu61ru2P3mBw4qVUq7ZtDpelQDRrK9O8Zutm
        NHz6a4uPVymZ+DAXXbpyb/uBxa3Shlg9F8fnCbvxK/eG3MHacV3URuPMrSXBiLxg
        Z3Vms/EY96Jc5lP/Ooi2R6X/ExjqmAl3P51T+c8B5fWmcBcUr2Ok/5mzk53cU6cG
        /kiFHaFpriV1uxPMUgP17VGhi9sVAgMBAAGjggEIMIIBBDAOBgNVHQ8BAf8EBAMC
        AYYwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMBMBIGA1UdEwEB/wQIMAYB
        Af8CAQAwHQYDVR0OBBYEFBQusxe3WFbLrlAJQOYfr52LFMLGMB8GA1UdIwQYMBaA
        FHm0WeZ7tuXkAXOACIjIGlj26ZtuMDIGCCsGAQUFBwEBBCYwJDAiBggrBgEFBQcw
        AoYWaHR0cDovL3gxLmkubGVuY3Iub3JnLzAnBgNVHR8EIDAeMBygGqAYhhZodHRw
        Oi8veDEuYy5sZW5jci5vcmcvMCIGA1UdIAQbMBkwCAYGZ4EMAQIBMA0GCysGAQQB
        gt8TAQEBMA0GCSqGSIb3DQEBCwUAA4ICAQCFyk5HPqP3hUSFvNVneLKYY611TR6W
        PTNlclQtgaDqw+34IL9fzLdwALduO/ZelN7kIJ+m74uyA+eitRY8kc607TkC53wl
        ikfmZW4/RvTZ8M6UK+5UzhK8jCdLuMGYL6KvzXGRSgi3yLgjewQtCPkIVz6D2QQz
        CkcheAmCJ8MqyJu5zlzyZMjAvnnAT45tRAxekrsu94sQ4egdRCnbWSDtY7kh+BIm
        lJNXoB1lBMEKIq4QDUOXoRgffuDghje1WrG9ML+Hbisq/yFOGwXD9RiX8F6sw6W4
        avAuvDszue5L3sz85K+EC4Y/wFVDNvZo4TYXao6Z0f+lQKc0t8DQYzk1OXVu8rp2
        yJMC6alLbBfODALZvYH7n7do1AZls4I9d1P4jnkDrQoxB3UqQ9hVl3LEKQ73xF1O
        yK5GhDDX8oVfGKF5u+decIsH4YaTw7mP3GFxJSqv3+0lUFJoi5Lc5da149p90Ids
        hCExroL1+7mryIkXPeFM5TgO9r0rvZaBFOvV2z0gp35Z0+L4WPlbuEjN/lxPFin+
        HlUjr8gRsI3qfJOQFy/9rKIJR0Y/8Omwt/8oTWgy1mdeHmmjk7j1nYsvC9JSQ6Zv
        MldlTTKB3zhThV1+XWYp6rjd5JW1zbVWEkLNxE7GJThEUG3szgBVGP7pSWTUTsqX
        nLRbwHOoq7hHwg==
        -----END CERTIFICATE-----
        -----BEGIN CERTIFICATE-----
        MIIFYDCCBEigAwIBAgIQQAF3ITfU6UK47naqPGQKtzANBgkqhkiG9w0BAQsFADA/
        MSQwIgYDVQQKExtEaWdpdGFsIFNpZ25hdHVyZSBUcnVzdCBDby4xFzAVBgNVBAMT
        DkRTVCBSb290IENBIFgzMB4XDTIxMDEyMDE5MTQwM1oXDTI0MDkzMDE4MTQwM1ow
        TzELMAkGA1UEBhMCVVMxKTAnBgNVBAoTIEludGVybmV0IFNlY3VyaXR5IFJlc2Vh
        cmNoIEdyb3VwMRUwEwYDVQQDEwxJU1JHIFJvb3QgWDEwggIiMA0GCSqGSIb3DQEB
        AQUAA4ICDwAwggIKAoICAQCt6CRz9BQ385ueK1coHIe+3LffOJCMbjzmV6B493XC
        ov71am72AE8o295ohmxEk7axY/0UEmu/H9LqMZshftEzPLpI9d1537O4/xLxIZpL
        wYqGcWlKZmZsj348cL+tKSIG8+TA5oCu4kuPt5l+lAOf00eXfJlII1PoOK5PCm+D
        LtFJV4yAdLbaL9A4jXsDcCEbdfIwPPqPrt3aY6vrFk/CjhFLfs8L6P+1dy70sntK
        4EwSJQxwjQMpoOFTJOwT2e4ZvxCzSow/iaNhUd6shweU9GNx7C7ib1uYgeGJXDR5
        bHbvO5BieebbpJovJsXQEOEO3tkQjhb7t/eo98flAgeYjzYIlefiN5YNNnWe+w5y
        sR2bvAP5SQXYgd0FtCrWQemsAXaVCg/Y39W9Eh81LygXbNKYwagJZHduRze6zqxZ
        Xmidf3LWicUGQSk+WT7dJvUkyRGnWqNMQB9GoZm1pzpRboY7nn1ypxIFeFntPlF4
        FQsDj43QLwWyPntKHEtzBRL8xurgUBN8Q5N0s8p0544fAQjQMNRbcTa0B7rBMDBc
        SLeCO5imfWCKoqMpgsy6vYMEG6KDA0Gh1gXxG8K28Kh8hjtGqEgqiNx2mna/H2ql
        PRmP6zjzZN7IKw0KKP/32+IVQtQi0Cdd4Xn+GOdwiK1O5tmLOsbdJ1Fu/7xk9TND
        TwIDAQABo4IBRjCCAUIwDwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMCAQYw
        SwYIKwYBBQUHAQEEPzA9MDsGCCsGAQUFBzAChi9odHRwOi8vYXBwcy5pZGVudHJ1
        c3QuY29tL3Jvb3RzL2RzdHJvb3RjYXgzLnA3YzAfBgNVHSMEGDAWgBTEp7Gkeyxx
        +tvhS5B1/8QVYIWJEDBUBgNVHSAETTBLMAgGBmeBDAECATA/BgsrBgEEAYLfEwEB
        ATAwMC4GCCsGAQUFBwIBFiJodHRwOi8vY3BzLnJvb3QteDEubGV0c2VuY3J5cHQu
        b3JnMDwGA1UdHwQ1MDMwMaAvoC2GK2h0dHA6Ly9jcmwuaWRlbnRydXN0LmNvbS9E
        U1RST09UQ0FYM0NSTC5jcmwwHQYDVR0OBBYEFHm0WeZ7tuXkAXOACIjIGlj26Ztu
        MA0GCSqGSIb3DQEBCwUAA4IBAQAKcwBslm7/DlLQrt2M51oGrS+o44+/yQoDFVDC
        5WxCu2+b9LRPwkSICHXM6webFGJueN7sJ7o5XPWioW5WlHAQU7G75K/QosMrAdSW
        9MUgNTP52GE24HGNtLi1qoJFlcDyqSMo59ahy2cI2qBDLKobkx/J3vWraV0T9VuG
        WCLKTVXkcGdtwlfFRjlBz4pYg1htmf5X6DYO8A4jqv2Il9DjXA6USbW1FzXSLr9O
        he8Y4IWS6wY7bCkjCWDcRQJMEhg76fsO3txE+FiYruq9RUWhiF1myv4Q6W+CyBFC
        Dfvp7OOGAN6dEOM4+qR9sdjoSYKEBpsr6GtPAQw4dy753ec5
        -----END CERTIFICATE-----


```
5. Browse to https://vault.dev.bigbang.mil
5. Set Method to Token and log in. To get the token, run:
```kubectl get secret -n vault vault-token -o go-template='{{.data.key | base64decode}}'```
5. Once you've logged in, choose Tools from the left-hand column. 
5. Now choose Random from the left-hand column. Click Generate to generate a random 32 byte base64 value. Copy this value to your clipboard. 
5. Click "back to main navigation." Under Secrets Engines on the main page, you should see the cubbyhole secrets engine. Click on it. 
5. Click Create Secret
5. Under "Path for this secret" enter ~
5. Under "Secret data" enter test01 for your secret and for the secret data, paste in the random base64 value you generated above. 
5. Click Save. Confirm that you see your secret listed.
5. In the left-hand column, click Policies. You should see these policies listed: default, prometheus-metrics, and root. 

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
## chart/templates/server-service.yaml
- add `prometeus-metrics: "true"` to end of `metadata: labels:`
## chart/templates/injector-deployment.yaml
- ensure `AGENT_INJECT_VAULT_ADDR` environment variable has third if else option checking for `.Values.server.ha.apiAddr`. This is a BigBang addition.
## chart/templates/csi-daemonset.yaml
- ensure `VAULT_ADDR` environment variable has if else option checking for `.Values.server.ha.apiAddr`. This is a BigBang addition.
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