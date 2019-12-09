locals {
  region                = data.aws_region.this.name
  authorizer_count      = var.authorizer_name == null ? 0 : 1
  authorizer_role_count = var.authorizer_type == "COGNITO_USER_POOLS" ? 0 : 1

  api_gateway_deployment_md5 = "nul"

  authorizer_uri_lambda    = var.lambda_function_name != null ? "arn:aws:apigateway:${local.region}:lambda:path/${data.aws_lambda_function.this[0].invoke_arn}" : null
  authorizer_uri           = var.lambda_function_name != null ? local.authorizer_uri_lambda : null
  authorizer_provider_arns = var.cognito_user_pool_name != null ? data.aws_cognito_user_pools.this[0].arns : null
  authorizer_credentials   = local.authorizer_role_count != 0 ? aws_iam_role.authorizer[0].arn : null
}

data "aws_region" "this" {
}

