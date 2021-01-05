#HSM Configuration

##Run terraform to provision the HSM (currently located here:)
###https://repo1.dso.mil/platform-one/private/cnap/terraform-live-p1-aws-dev/-/tree/master/platform1-il5-cnap-dev/cnap/k8s_clusters/vault/aws_hsm
###The CSR and HSM IP Address are displayed as a .tf output

##Sign the CSR with a CA (either DoD or self-signed)

##Initialize the cluster by following the procedures here: 
###https://docs.aws.amazon.com/cloudhsm/latest/userguide/initialize-cluster.html
###Start with self-signed CA procedures (if self-signing)

##Once the cluster is initialized and active, install the linux HSM client on your bastion:
##https://docs.aws.amazon.com/cloudhsm/latest/userguide/install-and-configure-client-linux.html
##```wget https://s3.amazonaws.com/cloudhsmv2-software/CloudHsmClient/EL6/cloudhsm-client-latest.el6.x86_64.rpm```
##```sudo yum install -y ./cloudhsm-client-latest.el6.x86_64.rpm```

##Import the CA.crt from the CA that signed your HSM csr and place it in the following directory:
###```/opt/cloudhsm/etc/```

##Update the config files for AWS HSM client
##```sudo /opt/cloudhsm/bin/configure -a <IP address>```

##Configure the HSM cluster from the bastion
##https://docs.aws.amazon.com/cloudhsm/latest/userguide/activate-cluster.html
##```/opt/cloudhsm/bin/cloudhsm_mgmt_util /opt/cloudhsm/etc/cloudhsm_mgmt_util.cfg```
##```enable_e2e```
##```listUsers```
##```loginHSM PRECO admin password```
##```changePswd PRECO admin <NewPassword>```
##```listUsers``` #notice the PRECO user 'admin' changed to a CO user

##Create/Modify/Delete necessary Crypto Officers, Crypto Users, Precrypto Users in the HSM (as needed)
##https://docs.aws.amazon.com/cloudhsm/latest/userguide/cli-users.html
##```createUser CU vault <password>
##Change passwords as needed
##```changePswd CO <username> <password>
