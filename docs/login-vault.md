# AutoUnseal and Init Default Token

To get the root token for the vault deployment (if using the developer autouseal/init):
 
```console
kubectl get secret -n vault vault-token -o go-template='{{.data.key | base64decode}}'
```
