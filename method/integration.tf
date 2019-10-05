# -------------------------------------------------------
# Amazon API Gateway Integration
# -------------------------------------------------------
resource "aws_api_gateway_integration" "this" {
  depends_on = [aws_api_gateway_method.this]

  rest_api_id             = var.rest_api_id
  resource_id             = var.resource_id
  http_method             = aws_api_gateway_method.this.http_method
  content_handling        = "CONVERT_TO_TEXT"
  integration_http_method = local.integration_http_method
  type                    = local.integration_type
  uri                     = var.lambda_function_uri

  lifecycle {
    create_before_destroy = false
  }
}

# -------------------------------------------------------
# Amazon API Gateway Integration Response
# -------------------------------------------------------
resource "aws_api_gateway_integration_response" "this" {
  depends_on = [aws_api_gateway_integration.this]

  rest_api_id = var.rest_api_id
  resource_id = var.resource_id
  http_method = aws_api_gateway_method.this.http_method
  status_code = local.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "integration.response.header.Access-Control-Allow-Origin"
  }
}

# -------------------------------------------------------
# Amazon API Gateway Integration - CORS
# -------------------------------------------------------
resource "aws_api_gateway_integration" "cors" {
  depends_on = [aws_api_gateway_method.cors]

  rest_api_id = var.rest_api_id
  resource_id = var.resource_id
  http_method = aws_api_gateway_method.cors[0].http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = "${jsonencode(local.status)}"
  }

  count = local.count_cors
}

# -------------------------------------------------------
# Amazon API Gateway Integration Response - CORS
# -------------------------------------------------------
resource "aws_api_gateway_integration_response" "cors" {
  depends_on = [aws_api_gateway_method_response.cors]

  rest_api_id = var.rest_api_id
  resource_id = var.resource_id
  http_method = aws_api_gateway_method.cors[0].http_method
  status_code = aws_api_gateway_method_response.cors[0].status_code

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
