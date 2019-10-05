locals {
  region                     = data.aws_region.this.name
  authorizer_count           = var.authorizer_name == null ? 0 : 1
  custom_domain_count        = var.custom_domain_name == null ? 0 : 1
  api_gateway_deployment_md5 = "nul"

  authorizer_uri_lambda    = "arn:aws:apigateway:${local.region}:lambda:path/${data.aws_lambda_function.this[0].invoke_arn}"
  authorizer_uri           = var.lambda_function_name != null ? local.authorizer_uri_lambda : null
  authorizer_provider_arns = var.cognito_user_pool_name != null ? data.aws_cognito_user_pools.this[0].arns : null
}

data "aws_region" "this" {
}

