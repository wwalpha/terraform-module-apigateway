# ------------------------------
# AWS Lambda Role Permission
# ------------------------------
resource "aws_lambda_permission" "lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = local.function_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${local.execution_arn}/*/${var.http_method}${local.resource_path}"
  qualifier     = local.function_alias

  count = var.integration_type == "AWS_PROXY" ? 1 : 0
}
