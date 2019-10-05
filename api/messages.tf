# -------------------------------------------------------
# Provider arns is required
# -------------------------------------------------------
# resource "null_resource" "authorizer_provider_arns_required" {
#   count = "${var.authorizer_type == "COGNITO_USER_POOLS" && local.authorizer_provider_arns == null ? 1 : 0}"
#   "ERROR: variable authorizer_provider_arns is required. " = true
# }
