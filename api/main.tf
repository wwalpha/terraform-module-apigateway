# ------------------------------------------------------------
# APIGateway REST API
# ------------------------------------------------------------
resource "aws_api_gateway_rest_api" "this" {
  name                     = var.api_name
  description              = var.api_description
  binary_media_types       = var.api_binary_media_types
  minimum_compression_size = var.api_minimum_compression_size
  body                     = var.api_body
  policy                   = var.api_policy
  api_key_source           = var.api_key_source

  endpoint_configuration {
    types = [var.api_endpoint_configuration]
  }
}

