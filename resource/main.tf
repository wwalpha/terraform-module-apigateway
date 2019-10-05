terraform {
  required_version = ">= 0.12"
}
# -------------------------------------------------------
# Amazon API Gateway Resource
# -------------------------------------------------------
resource "aws_api_gateway_resource" "this" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = var.path_part
}
