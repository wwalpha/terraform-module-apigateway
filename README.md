# Terraform Modules - API Gateway

## Examples

- [Default REST API](#default-rest-api)
- [Custom Domain Names](#custom-domain-names)
- [Authorizer Cognito](#authorizer-cognito)
- [Lambda Integration](#lambda-integration)

### Default REST API

```terraform
# -------------------------------------------------------
# Amazon API REST API
# -------------------------------------------------------
module "api" {
  source   = "github.com/wwalpha/terraform-module-apigateway/api"
  api_name = "examples"
}

# -------------------------------------------------------
# Amazon API Resource
# -------------------------------------------------------
module "resource" {
  source       = "github.com/wwalpha/terraform-module-apigateway/resource"
  rest_api_id  = "${module.api.id}"
  parent_id    = "${module.api.root_resource_id}"
  path_part    = "test"
  cors_enabled = true
}

# -------------------------------------------------------
# Amazon API Deployment
# -------------------------------------------------------
module "deployment" {
  source          = "github.com/wwalpha/terraform-module-apigateway/deployment"
  rest_api_id     = "${module.api.id}"
  integration_ids = ["${module.resource.cors_integration_id}"]
  deployment_md5  = "${base64encode(file("main.tf"))}"
}
```

### Custom Domain Names

```terraform
# -------------------------------------------------------
# Amazon API REST API
# -------------------------------------------------------
module "api" {
  source   = "github.com/wwalpha/terraform-module-apigateway/api"
  api_name = "examples"
}

# -------------------------------------------------------
# Amazon API Resource
# -------------------------------------------------------
module "resource" {
  source       = "github.com/wwalpha/terraform-module-apigateway/resource"
  rest_api_id  = "${module.api.id}"
  parent_id    = "${module.api.root_resource_id}"
  path_part    = "test"
  cors_enabled = true
}

# -------------------------------------------------------
# Amazon API Deployment
# -------------------------------------------------------
module "deployment" {
  source                                 = "github.com/wwalpha/terraform-module-apigateway/deployment"
  rest_api_id                            = "${module.api.id}"
  custom_domain_name                     = "${aws_acm_certificate.api.domain_name}"
  custom_domain_regional_certificate_arn = "${aws_acm_certificate_validation.api.certificate_arn}"
  custom_domain_endpoint_configuration   = "${local.api_endpoint_configuration}"
  integration_ids                        = ["${module.resource.cors_integration_id}"]
  deployment_md5                         = "${base64encode(file("main.tf"))}"
}
```

### Authorizer Cognito

```terraform
# -----------------------------------------------
# Amazon Cognito
# -----------------------------------------------
module "cognito" {
  source             = "github.com/wwalpha/terraform-module-cognito"
  user_pool_name     = "UserPoolExample"
  identity_pool_name = "IdentityPoolExample"
}

# -------------------------------------------------------
# Amazon API REST API
# -------------------------------------------------------
module "api" {
  source                           = "github.com/wwalpha/terraform-module-apigateway/api"
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
  source       = "github.com/wwalpha/terraform-module-apigateway/resource"
  rest_api_id  = "${module.api.id}"
  parent_id    = "${module.api.root_resource_id}"
  path_part    = "test"
  cors_enabled = true
}

# -------------------------------------------------------
# Amazon API Deployment
# -------------------------------------------------------
module "deployment" {
  source          = "github.com/wwalpha/terraform-module-apigateway/deployment"
  rest_api_id     = "${module.api.id}"
  stage_name      = "v2"
  deployment_md5  = "${base64encode(filemd5("main.tf"))}"
  integration_ids = ["${module.resource.cors_integration_id}"]
}
```

### Lambda Integration

```terraform
# --------------------------------------------------------------------------------
# AWS Lambda
# --------------------------------------------------------------------------------
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

# --------------------------------------------------------------------------------
# Amazon API REST API
# --------------------------------------------------------------------------------
module "api" {
  source   = "github.com/wwalpha/terraform-module-apigateway/api"
  api_name = "example"
}

# --------------------------------------------------------------------------------
# Amazon API Resource
# --------------------------------------------------------------------------------
module "resource" {
  source      = "github.com/wwalpha/terraform-module-apigateway/resource"
  rest_api_id = "${module.api.id}"
  parent_id   = "${module.api.root_resource_id}"
  path_part   = "test"
}

# --------------------------------------------------------------------------------
# Amazon API Method
# --------------------------------------------------------------------------------
module "method" {
  source              = "github.com/wwalpha/terraform-module-apigateway/method"
  rest_api_id         = "${module.api.id}"
  resource_id         = "${module.resource.id}"
  resource_path       = "${module.resource.path}"
  lambda_function_uri = "${module.lambda.invoke_arn}"
}

# --------------------------------------------------------------------------------
# Amazon API Deployment
# --------------------------------------------------------------------------------
module "deployment" {
  source          = "github.com/wwalpha/terraform-module-apigateway/deployment"
  rest_api_id     = "${module.api.id}"
  integration_ids = ["${module.method.integration_id}"]
  deployment_md5  = "${base64encode(file("main.tf"))}"
}

```
