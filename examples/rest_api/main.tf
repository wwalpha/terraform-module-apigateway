provider "aws" {}

# -----------------------------------------------
# Amazon Cognito
# -----------------------------------------------
module "cognito" {
  source = "github.com/wwalpha/terraform-module-cognito"

  user_pool_name     = "${local.project_name_uc}-UserPool"
  identity_pool_name = "${local.project_name_uc}_IdentityPool"
}

# -------------------------------------------------------
# Amazon API REST API
# -------------------------------------------------------
module "api" {
  source = "../../api"

  api_name = "examples"
}

# -------------------------------------------------------
# Amazon API Resource
# -------------------------------------------------------
module "resource" {
  source = "../../resource"

  rest_api_id  = "${module.api.id}"
  parent_id    = "${module.api.root_resource_id}"
  path_part    = "test"
  cors_enabled = true
}

# -------------------------------------------------------
# Amazon API Method
# -------------------------------------------------------
module "method" {
  source = "../../method"

  rest_api_id         = "${module.api.id}"
  resource_id         = "${module.resource.id}"
  http_method         = "GET"
  lambda_function_uri = "${module.lambda.invoke_arn}"
}


# -------------------------------------------------------
# Amazon API Deployment
# -------------------------------------------------------
module "deployment" {
  source = "github.com/wwalpha/terraform-module-apigateway/deployment"

  rest_api_id                            = "${module.api.id}"
  stage_name                             = "v1"
  custom_domain_name                     = "${aws_acm_certificate.api.domain_name}"
  custom_domain_regional_certificate_arn = "${aws_acm_certificate_validation.api.certificate_arn}"
  custom_domain_endpoint_configuration   = "${local.api_endpoint_configuration}"

  integration_ids = [
    "${module.method.integration_id}",
  ]

  deployment_md5 = "${base64encode(join("", local.deployment_files))}"
}
