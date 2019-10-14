provider "aws" {}

module "lambda" {
  source        = "github.com/wwalpha/terraform-module-lambda"
  dummy_enabled = true
  function_name = "LambdaExample"
  alias_name    = "dev"
  handler       = "index.handler"
  runtime       = "nodejs10.x"
  memory_size   = 512
  role_name     = "LambdaExampleRole"
}

# -------------------------------------------------------
# Amazon API REST API
# -------------------------------------------------------
module "api" {
  source   = "../../api"
  api_name = "examples"
}

# --------------------------------------------------------------------------------
# Amazon API Resource
# --------------------------------------------------------------------------------
module "resource" {
  source      = "../../resource"
  rest_api_id = "${module.api.id}"
  parent_id   = "${module.api.root_resource_id}"
  path_part   = "test"
}

# -------------------------------------------------------
# Amazon API Method
# -------------------------------------------------------
module "method" {
  source              = "../../method"
  rest_api_id         = "${module.api.id}"
  resource_id         = "${module.resource.id}"
  resource_path       = "${module.resource.path}"
  lambda_function_uri = "${module.lambda.invoke_arn}"
}

# -------------------------------------------------------
# Amazon API Deployment
# -------------------------------------------------------
module "deployment" {
  source          = "../../deployment"
  rest_api_id     = "${module.api.id}"
  integration_ids = ["${module.method.integration_id}"]
  deployment_md5  = "${base64encode(file("main.tf"))}"
}
