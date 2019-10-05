locals {
  integration_http_method = "POST"
  integration_type        = "AWS_PROXY"
  status_code             = "200"

  status = {
    statusCode = 200
  }

  count_cors = var.cors_enabled ? 1 : 0
}
