# -------------------------------------------------------
# Amazon API Gateway Deployment
# -------------------------------------------------------
resource "aws_api_gateway_deployment" "this" {
  depends_on = [aws_api_gateway_integration.this]

  rest_api_id = aws_api_gateway_rest_api.this.id

  # variables = {
  #   deployment_md5 = "${local.api_gateway_deployment_md5}"
  # }

  lifecycle {
    create_before_destroy = true
  }
}

# -------------------------------------------------------
# Amazon API Gateway Stage
# # -----------------------------------------------------
resource "aws_api_gateway_stage" "this" {
  stage_name           = var.stage_name
  rest_api_id          = aws_api_gateway_rest_api.this.id
  deployment_id        = aws_api_gateway_deployment.this.id
  xray_tracing_enabled = var.stage_xray_enabled
}

