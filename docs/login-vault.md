AutoUnseal and Init

Get the root token for the vault deployment  for the initial login
 
 kubectl get secret vault-token -n vault  -o jsonpath='{.data}'

