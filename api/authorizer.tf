data "aws_lambda_function" "this" {
  function_name = var.lambda_function_name
  count         = var.lambda_function_name != null ? 1 : 0
}

data "aws_cognito_user_pools" "this" {
  name  = var.cognito_user_pool_name
  count = var.cognito_user_pool_name != null ? 1 : 0
}

# -------------------------------------------------------
# Amazon API Gateway Authorizer
# -------------------------------------------------------
resource "aws_api_gateway_authorizer" "this" {
  rest_api_id                      = aws_api_gateway_rest_api.this.id
  name                             = var.authorizer_name
  authorizer_uri                   = local.authorizer_uri
  identity_source                  = var.authorizer_identity_source
  type                             = var.authorizer_type
  authorizer_credentials           = aws_iam_role.authorizer[0].arn
  authorizer_result_ttl_in_seconds = var.authorizer_result_ttl_in_seconds
  identity_validation_expression   = var.authorizer_identity_validation_expression
  provider_arns                    = local.authorizer_provider_arns

  count = local.authorizer_count
}

# -------------------------------------------------------
# Amazon API Gateway Authorizer Role
# -------------------------------------------------------
resource "aws_iam_role" "authorizer" {
  name = var.authorizer_role_name
  path = "/"

  assume_role_policy = file("${path.module}/iam/apigateway_principals.json")

  count = local.authorizer_count
}

# -------------------------------------------------------
# Amazon API Gateway Authorizer Policy
# -------------------------------------------------------
# resource "aws_iam_role_policy" "authorizer" {
#   role   = "${aws_iam_role.authorizer.0.id}"
#   policy = "${var.authorizer_policy}"
#   count = "${local.authorizer_count}"
# }
