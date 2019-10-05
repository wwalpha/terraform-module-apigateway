# -------------------------------------------------------
# Amazon API Gateway Integration - Lambda
# -------------------------------------------------------
resource "aws_api_gateway_integration" "lambda" {
  rest_api_id             = var.rest_api_id
  resource_id             = var.resource_id
  http_method             = aws_api_gateway_method.this.http_method
  content_handling        = "CONVERT_TO_TEXT"
  integration_http_method = local.integration_http_method
  type                    = var.integration_type
  uri                     = var.lambda_function_uri

  lifecycle {
    create_before_destroy = false
  }

  count = var.integration_type == "AWS_PROXY" ? 1 : 0
}

# -------------------------------------------------------
# Amazon API Gateway Integration Response - Lambda
# -------------------------------------------------------
resource "aws_api_gateway_integration_response" "lambda" {
  depends_on = [aws_api_gateway_integration.lambda]

  rest_api_id = var.rest_api_id
  resource_id = var.resource_id
  http_method = aws_api_gateway_method.this.http_method
  status_code = local.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "integration.response.header.Access-Control-Allow-Origin"
  }
}

# -------------------------------------------------------
# Amazon API Gateway Integration - mock
# -------------------------------------------------------
resource "aws_api_gateway_integration" "mock" {
  rest_api_id = var.rest_api_id
  resource_id = var.resource_id
  http_method = aws_api_gateway_method.this.http_method
  type        = var.integration_type

  request_templates = {
    "application/json" = "${jsonencode(local.status_200)}"
  }

  count = var.integration_type == "MOCK" ? 1 : 0
}

# -------------------------------------------------------
# Amazon API Gateway Integration Response - Lambda
# -------------------------------------------------------
resource "aws_api_gateway_integration_response" "mock" {
  depends_on = [aws_api_gateway_integration.mock]

  rest_api_id = var.rest_api_id
  resource_id = var.resource_id
  http_method = aws_api_gateway_method.this.http_method
  status_code = local.status_200.statusCode

  response_templates = {
    "application/json" = var.response_templates
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  count = var.integration_type == "MOCK" ? 1 : 0
}
