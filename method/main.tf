terraform {
  required_version = ">= 0.12"
}

# resource "aws_api_gateway_request_validator" "this" {
#   name                        = "${local.resource_id}_${var.http_method}_validator"
#   rest_api_id                 = var.rest_api_id
#   validate_request_parameters = true
# }

