# deployment-guide

# terragrunt

### network

[ ]  Vault VPC
    [ ]  transit gw attachment
    [ ]  private-subnet with route to transit-gw
[ ]  Vault TGW route
[ ]  Ingress TGW route
[ ]  connectivity to gitlab for flux

### kube cluster

[ ]  keypair
[ ]  kms-sops-key
[ ]  kms-sops-policy
[ ]  rke_server nodes
[ ]  rke_worker nodes
[ ]  kms-policy-attachment
[ ]  bastion
[ ]  tag subnets with RKE generated cluster name - (done from the VPC resource which kubernetes runs on)

### vault backend

[ ]  s3 bucket
[ ]  dynamodb table

# kubernetes

[ ]  clone repo

```bash
git clone https://code.il5.dso.mil/cnap/cubbyhole.git
```

[ ]  taint kubernetes master nodes

```bash
kubectl describe nodes |grep -i taint
kubectl taint nodes -l node-role.kubernetes.io/master=true  node-role.kubernetes.io/master:NoSchedule
kubectl describe nodes |grep -i taint
```

[ ]  patch build-in RKE2 pod security policy

```bash
kubectl patch psp system-unrestricted-psp  -p '{"metadata": {"annotations":{"seccomp.security.alpha.kubernetes.io/allowedProfileNames": "*"}}}'
kubectl patch psp global-unrestricted-psp  -p '{"metadata": {"annotations":{"seccomp.security.alpha.kubernetes.io/allowedProfileNames": "*"}}}'
kubectl patch psp global-restricted-psp  -p '{"metadata": {"annotations":{"seccomp.security.alpha.kubernetes.io/allowedProfileNames": "*"}}}'
```

[ ]  ebs

```bash
kubectl apply -f deploy/prod/ebs/gp2-storage-class.yaml
```

[ ]  flux

```bash
kubectl apply -f deploy/prod/flux/flux-install.yaml
```

[ ]  bigbang

```bash
kubectl create namespace bigbang
sops -i -d deploy/prod/bb-umbrella/secrets/repo-credentials.enc.yaml
kubectl apply -f deploy/prod/bb-umbrella/secrets/repo-credentials.enc.yaml
kustomize build deploy/prod/bb-umbrella/ |kubectl apply -f -
kubectl get hr,svc -A

# re-encryt repo credentials
sops -i -e deploy/prod/bb-umbrella/secrets/repo-credentials.enc.yaml

```

[ ]  vault

```bash

sops -i -d deploy/prod/vault/secrets/repo-credentials.enc.yaml
kubectl apply -f deploy/prod/vault/namespace.yaml
kubectl apply -f deploy/prod/vault/secrets/repo-credential.enc.yaml
kubectl apply -f deploy/prod/vault/gitrepository.yaml
kubectl apply -f deploy/prod/vault/flux-kustomization.yaml

# re-encryt repo credentials
sops -i -e deploy/prod/vault/secrets/repo-credentials.enc.yaml
```

# vault

[ ]  cluster initialization

```bash

# add entry to /etc/hosts (private IP of istio/AWS LB)
10.122.24.30    vault.staging.dso.mil

export VAULT_ADDR=https://vault.staging.dso.mil

vault status

# initialize the cluster with pgp public keys of trusted individuals
vault operator init -recovery-shares=3 -recovery-threshold=2 -recovery-pgp-keys="israel.asc, cam.asc, gabe.asc" -root-token-pgp-key="cam.asc" -tls-skip-verify

# decrypt root token and login
vault login 

vault write sys/license text=9y4923y489h2fasdkjfhaolwuhfg;aoiwhfoihawu4fhbiuaw2hbfiua3ghfb2p3098ry1293r8

```

[ ]  config as code

```bash

cd /env/dev/config-as-code/

# initialize vault app s3+dynamodb backend for tf state
terraform init

# enable auditing
vault audit enable file file_path=/tmp/audit.log

# terraform plan and inspect
terraform plan 
terraform apply 

# what does the tf do?
create user passcreate notaries
create vault_identity_group resources
create pki mounts
create pki csr,cert resources
create vault_pki_secret_backend_role 

```