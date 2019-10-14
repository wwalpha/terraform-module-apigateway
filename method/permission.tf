# ------------------------------
# AWS Lambda Role Permission
# ------------------------------
resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = local.function_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${local.execution_arn}/*/${var.http_method}${local.resource_path}"

  count = local.function_arn != null ? 1 : 0
}
