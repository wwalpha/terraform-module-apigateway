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
  source                           = "../../api"
  api_name                         = "examples"
  cognito_user_pool_name           = "${module.cognito.user_pool_name}"
  authorizer_name                  = "CognitoAuthorizer"
  authorizer_type                  = "COGNITO_USER_POOLS"
  authorizer_result_ttl_in_seconds = 0
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
  source = "../../deployment"

  rest_api_id     = "${module.api.id}"
  stage_name      = "v2"
  deployment_md5  = "${base64encode(filemd5("main.tf"))}"
  integration_ids = ["${module.resource.cors_integration_id}"]
}
