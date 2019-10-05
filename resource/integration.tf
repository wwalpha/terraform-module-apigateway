# -------------------------------------------------------
# Amazon API Gateway Integration
# -------------------------------------------------------
resource "aws_api_gateway_integration" "this" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.this[0].http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = "${jsonencode(local.status)}"
  }

  count = local.count_cors
}

# -------------------------------------------------------
# Amazon API Gateway Integration Response - this
# -------------------------------------------------------
resource "aws_api_gateway_integration_response" "this" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.this[0].http_method
  status_code = aws_api_gateway_method_response.this[0].status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = var.allow_header
    "method.response.header.Access-Control-Allow-Methods" = var.allow_method
    "method.response.header.Access-Control-Allow-Origin"  = var.allow_origin
  }

  response_templates = {
    "application/json" = ""
  }

  count = local.count_cors
}
