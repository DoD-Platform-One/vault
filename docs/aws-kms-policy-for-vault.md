# Vault

vault needs this kms policy applied to the workers in order to unseal with AWS KMS

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:DescribeKey"
            ],
            "Resource": [
                "<kms-arn>"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "kms:GenerateRandom"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow"
        }
    ]
}
```