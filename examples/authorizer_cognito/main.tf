provider "aws" {}

# -----------------------------------------------
# Amazon Cognito
# -----------------------------------------------
module "cognito" {
  source = "github.com/wwalpha/terraform-module-cognito"

  user_pool_name     = "UserPoolExample"
  identity_pool_name = "IdentityPoolExample"
}

# -------------------------------------------------------
# Amazon API REST API
# -------------------------------------------------------
module "api" {
  source = "../../api"

  api_name = "examples"

  cognito_user_pool_name           = "${module.cognito.user_pool_name}"
  authorizer_name                  = "CognitoAuthorizer"
  authorizer_type                  = "COGNITO_USER_POOLS"
  authorizer_result_ttl_in_seconds = 0
}

# -------------------------------------------------------
# Amazon API Deployment
# -------------------------------------------------------
module "deployment" {
  source = "../../deployment"

  rest_api_id     = "${module.api.id}"
  stage_name      = "v2"
  description     = "deployment description"
  deployment_md5  = "${base64encode(join("", local.api_gateway_files))}"
  integration_ids = ["${module.method.integration_id}"]
}
