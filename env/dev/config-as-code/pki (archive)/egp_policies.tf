resource "vault_egp_policy" "p1_leaf_validate_common_name" {
  name = "p1-leaf-validate-common-name"
  paths = [
    # will add these restrictions to a separate policy
    # "pki/int/p1_int/issue/p1-leaf-cert",
    # "pki/int/p1_int/sign/p1-leaf-cert",
    "pki/il5/p1_int/issue/il5-p1-leaf-cert",
    "pki/il5/p1_int/sign/il5-p1-leaf-cert",
    "pki/il4/p1_int/issue/il4-p1-leaf-cert",
    "pki/il4/p1_int/sign/il4-p1-leaf-cert",
    "pki/il2/p1_int/issue/il2-p1-leaf-cert",
    "pki/il2/p1_int/sign/il2-p1-leaf-cert",
  ]
  enforcement_level = "hard-mandatory"

  policy = file("sentinel/validate-common-name.sentinel")
}