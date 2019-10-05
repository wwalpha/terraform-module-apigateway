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
  api_id      = aws_api_gateway_rest_api.this.id
  base_path   = var.custom_domain_base_path
  stage_name  = aws_api_gateway_stage.this.stage_name
  domain_name = aws_api_gateway_domain_name.this[0].domain_name

  count = local.custom_domain_count
}

