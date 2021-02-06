# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  # Gabe
  #source = "/Users/gabe/Workspace/terraform-modules/vault/mount"
  source = "/Users/cameron.banowsky/infrastructure/dev/repo1/cnap/terraform-modules/vault/pki_secret_backend_role"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency mount {
  config_path = "../../sub_int_ca/dso_mil/mount"
  mock_outputs = {
    path = "abc-123"
  }
}

inputs = {
    mount_path = dependency.mount.outputs.path
    name = "p1-dso-mil-leaf"
    allowed_domains = ["dso.mil"]
    allow_subdomains = false
    max_ttl = 94608000
    ttl = 94608000
    key_usage = ["DigitalSignature", "KeyAgreement", "KeyEncipherment"]
}