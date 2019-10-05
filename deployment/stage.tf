# -------------------------------------------------------
# Amazon API Gateway Stage
# # -----------------------------------------------------
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
