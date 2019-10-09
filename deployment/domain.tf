# -------------------------------------------------------
# Amazon API Gateway Domain Name
# -------------------------------------------------------
resource "aws_api_gateway_domain_name" "this" {
  domain_name              = var.custom_domain_name
  regional_certificate_arn = var.custom_domain_regional_certificate_arn

  endpoint_configuration {
    types = [var.custom_domain_endpoint_configuration]
  }

  count = local.custom_domain_count
}

# -------------------------------------------------------
# Amazon API BASE PATH MAPPING
# -------------------------------------------------------
resource "aws_api_gateway_base_path_mapping" "this" {
  depends_on  = [aws_api_gateway_domain_name.this]
  api_id      = var.rest_api_id
  base_path   = var.custom_domain_base_path
  stage_name  = var.stage_name
  domain_name = var.custom_domain_name

  count = local.custom_domain_count
}

