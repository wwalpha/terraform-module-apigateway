provider "aws" {}

# -------------------------------------------------------
# Amazon API REST API
# -------------------------------------------------------
module "api" {
  source = "../../api"

  api_name = "examples"
}

# --------------------------------------------------------------------------------
# Amazon API Resource
# --------------------------------------------------------------------------------
module "resource" {
  source = "../../resource"

  rest_api_id  = "${module.api.id}"
  parent_id    = "${module.api.root_resource_id}"
  path_part    = "test"
  cors_enabled = true
}

# -------------------------------------------------------
# Amazon API Deployment
# -------------------------------------------------------
module "deployment" {
  source                                 = "../../deployment"
  rest_api_id                            = "${module.api.id}"
  custom_domain_name                     = "${aws_acm_certificate.api.domain_name}"
  custom_domain_regional_certificate_arn = "${aws_acm_certificate_validation.api.certificate_arn}"
  custom_domain_endpoint_configuration   = "${local.api_endpoint_configuration}"
  integration_ids                        = ["${module.resource.cors_integration_id}"]
  deployment_md5                         = "${base64encode(file("main.tf"))}"
}
