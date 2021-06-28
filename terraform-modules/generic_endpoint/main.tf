resource "vault_generic_endpoint" "this" {
  path                 = var.path
  data_json            = var.data_json
  ignore_absent_fields = var.ignore_absent_fields
}
