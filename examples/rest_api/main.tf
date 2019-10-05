provider "aws" {}

# -------------------------------------------------------
# Amazon Lambda Function
# -------------------------------------------------------
module "lambda" {
  source = "github.com/wwalpha/terraform-module-registry/aws/lambda"

  enable_dummy  = true
  function_name = "lambda-example"
  handler       = "index.handler"
  runtime       = "nodejs10.x"
  role_name     = "LambdaExampleRole"
  timeout       = 5
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
  lambda_function_uri = "${module.lambda.invoke_arn}"
}

# -------------------------------------------------------
# Amazon API Deployment
# -------------------------------------------------------
module "deployment" {
  source = "../../deployment"

  rest_api_id = "${module.api.id}"
  stage_name  = "v2"
  description = "deployment description"
  deployment_md5 = "${base64encode(join("", [
    file("main.tf"),
    "${module.method.integration_id}"
  ]))}"
  xray_tracing_enabled = true
  stage_description    = "stage description"
  stage_tags = {
    Name = "test"
  }
}
