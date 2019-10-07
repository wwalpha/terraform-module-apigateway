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
  variables   = var.deployment_variables

  lifecycle {
    create_before_destroy = true
  }
}

# -------------------------------------------------------
# Amazon Depend on module
# -------------------------------------------------------
resource "null_resource" "depend_on_module" {
  triggers = {
    integration_ids = "${join("", var.integration_ids)}"
  }
}
