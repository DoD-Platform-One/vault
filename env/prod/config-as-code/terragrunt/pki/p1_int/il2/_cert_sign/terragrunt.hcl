# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://repo1.dso.mil/platform-one/private/cnap/terraform-modules.git//vault/pki_secret_backend_root_sign_intermediate?ref=vault"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency p1_int_mount {
  config_path = "../../_mount"
  mock_outputs = {
    path = "abc-123"
  }
}

dependency csr {
  config_path = "../_csr"
  mock_outputs = {
    csr = "-----BEGIN CERTIFICATE REQUEST-----"
  }
}

inputs = {
  sub_ca_csr_cn = "il2.dso.mil"
  int_mount_path = dependency.p1_int_mount.outputs.path
  csr = dependency.csr.outputs.csr
}
