# --------------------------------------------------------------------------------
# Amazon Lambda Function
# --------------------------------------------------------------------------------
module "lambda" {
  source = "github.com/wwalpha/terraform-module-registry/aws/lambda"

  dummy_enabled = true
  function_name = "lambda-example"
  handler       = "index.handler"
  runtime       = "nodejs10.x"
  role_name     = "LambdaExampleRole"
  timeout       = 5
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

# --------------------------------------------------------------------------------
# Amazon API Method
# --------------------------------------------------------------------------------
module "method" {
  source = "../../method"

  rest_api_id         = "${module.api.id}"
  resource_id         = "${module.resource.id}"
  http_method         = "GET"
  authorization       = "COGNITO_USER_POOLS"
  authorizer_id       = "${module.api.authorizer_id}"
  lambda_function_uri = "${module.lambda.invoke_arn}"
}
