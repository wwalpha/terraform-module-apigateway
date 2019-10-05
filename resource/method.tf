# -------------------------------------------------------
# Amazon API Gateway Method - this
# -------------------------------------------------------
resource "aws_api_gateway_method" "this" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.this.id
  http_method   = "OPTIONS"
  authorization = "NONE"

  lifecycle {
    create_before_destroy = false
  }

  count = local.count_cors
}


# -------------------------------------------------------
# Amazon API Gateway Method Response - this
# -------------------------------------------------------
resource "aws_api_gateway_method_response" "this" {
  depends_on = [aws_api_gateway_method.this]

  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.this[0].http_method
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
