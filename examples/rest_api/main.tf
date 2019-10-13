provider "aws" {}

# -------------------------------------------------------
# Amazon API REST API
# -------------------------------------------------------
module "api" {
  source   = "../../api"
  api_name = "examples"
}

# -------------------------------------------------------
# Amazon API Resource
# -------------------------------------------------------
module "resource" {
  source       = "../../resource"
  rest_api_id  = "${module.api.id}"
  parent_id    = "${module.api.root_resource_id}"
  path_part    = "test"
  cors_enabled = true
}

# -------------------------------------------------------
# Amazon API Deployment
# -------------------------------------------------------
module "deployment" {
  source          = "../../deployment"
  rest_api_id     = "${module.api.id}"
  integration_ids = ["${module.resource.cors_integration_id}"]
  deployment_md5  = "${base64encode(file("main.tf"))}"
}
