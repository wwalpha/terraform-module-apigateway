locals {
  integration_http_method = "POST"
  status_code             = "200"

  status_200 = {
    statusCode = 200
  }

  account_id    = data.aws_caller_identity.this.account_id
  region        = data.aws_region.this.name
  execution_arn = "arn:aws:execute-api:${local.region}:${local.account_id}:${var.rest_api_id}"
  resource_path = "${replace(var.resource_path, "/(\\{.*?\\})+/", "*")}"
  # -------------------------------------------------------
  # Lambda
  # -------------------------------------------------------
  function_arn   = var.lambda_function_uri != null ? split("/", var.lambda_function_uri)[3] : null
  function_name  = local.function_arn != null ? split(":", local.function_arn)[6] : null
  function_alias = local.function_arn != null ? split(":", local.function_arn)[7] : null
}

# -------------------------------------------------------
# AWS Account
# -------------------------------------------------------
data "aws_caller_identity" "this" {}

# -------------------------------------------------------
# AWS Region
# -------------------------------------------------------
data "aws_region" "this" {}

# -------------------------------------------------------
# Amazon Depend on module
# -------------------------------------------------------
resource "null_resource" "depend_on_lambda" {
  triggers = {
    lambda_function_uri = var.lambda_function_uri
  }
}
