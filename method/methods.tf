# -------------------------------------------------------
# Amazon API Gateway Method
# -------------------------------------------------------
resource "aws_api_gateway_method" "this" {
  rest_api_id        = var.rest_api_id
  resource_id        = var.resource_id
  http_method        = var.http_method
  authorization      = var.authorization
  authorizer_id      = var.authorizer_id
  api_key_required   = var.api_key_required
  request_parameters = var.request_parameters

  # request_validator_id = aws_api_gateway_request_validator.this.id

  lifecycle {
    create_before_destroy = false
  }
}

# -------------------------------------------------------
# Amazon API Gateway Method Response
# -------------------------------------------------------
resource "aws_api_gateway_method_response" "this" {
  depends_on = [aws_api_gateway_method.this]

  rest_api_id = var.rest_api_id
  resource_id = var.resource_id
  http_method = var.http_method
  status_code = local.status_code

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}


# -------------------------------------------------------
# Amazon API Gateway Method - CORS
# -------------------------------------------------------
resource "aws_api_gateway_method" "cors" {
  rest_api_id   = var.rest_api_id
  resource_id   = var.resource_id
  http_method   = "OPTIONS"
  authorization = "NONE"

  lifecycle {
    create_before_destroy = false
  }

  count = local.count_cors
}


# -------------------------------------------------------
# Amazon API Gateway Method Response - CORS
# -------------------------------------------------------
resource "aws_api_gateway_method_response" "cors" {
  depends_on = [aws_api_gateway_method.cors]

  rest_api_id = var.rest_api_id
  resource_id = var.resource_id
  http_method = aws_api_gateway_method.cors[0].http_method
  status_code = local.status_code

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = false,
    "method.response.header.Access-Control-Allow-Methods" = false,
    "method.response.header.Access-Control-Allow-Origin"  = false
  }

  count = local.count_cors
}
