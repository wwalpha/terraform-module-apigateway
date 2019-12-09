terraform {
  required_version = ">= 0.12"
}

# -------------------------------------------------------
# Amazon API Gateway Deployment
# -------------------------------------------------------
resource "aws_api_gateway_deployment" "this" {
  depends_on = [null_resource.depend_on_module]

  rest_api_id = var.rest_api_id
  description = var.description
  variables = {
    deployment_md5 = var.deployment_md5
  }

  lifecycle {
    create_before_destroy = true
  }
}

# -------------------------------------------------------
# Amazon API Gateway Stage
# -------------------------------------------------------
resource "aws_api_gateway_stage" "this" {
  rest_api_id           = var.rest_api_id
  stage_name            = var.stage_name
  description           = var.stage_description
  deployment_id         = aws_api_gateway_deployment.this.id
  cache_cluster_enabled = var.cache_cluster_enabled
  cache_cluster_size    = var.cache_cluster_size
  client_certificate_id = var.client_certificate_id
  documentation_version = var.documentation_version
  variables             = var.stage_variables
  tags                  = var.stage_tags
  xray_tracing_enabled  = var.xray_tracing_enabled

  dynamic "access_log_settings" {
    for_each = var.access_log_settings

    content {
      destination_arn = access_log_settings.destination_arn
      format          = access_log_settings.format
    }
  }
}

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
  stage_name  = aws_api_gateway_stage.this.stage_name
  domain_name = var.custom_domain_name

  count = local.custom_domain_count
}

# -------------------------------------------------------
# Amazon Depend on module
# -------------------------------------------------------
resource "null_resource" "depend_on_module" {
  triggers = {
    integration_ids = "${join("", var.integration_ids)}"
  }
}
