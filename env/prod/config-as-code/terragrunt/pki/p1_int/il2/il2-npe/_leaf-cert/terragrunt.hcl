# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/pki_secret_backend_role?ref=vault"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency mount {
  config_path = "../_mount"
  mock_outputs = {
    path = "abc-123"
  }
}

inputs = {
    mount_path = dependency.mount.outputs.path
    name = "il2-npe-leaf"
    allowed_domains = ["npe.il2.dso.mil"]
    max_ttl = 31556926 #annual lease
    ttl = 31556926 #annual lease
    key_usage = ["DigitalSignature", "KeyAgreement", "KeyEncipherment"]
}
