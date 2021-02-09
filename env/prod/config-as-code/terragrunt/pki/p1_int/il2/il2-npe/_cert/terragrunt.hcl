# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/pki_secret_backend_intermediate_set_signed?ref=vault"
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

dependency cert {
  config_path = "../_cert_sign"
  mock_outputs = {
    signed_cert = "-----BEGIN CERTIFICATE-----"
  }
}

inputs = {
  mount_path = dependency.mount.outputs.path
  signed_cert_and_ca_chain = dependency.cert.outputs.signed_cert
}
