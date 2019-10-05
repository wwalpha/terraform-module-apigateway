# ------------------------------------------------------------------------------------------------
# The ID of the associated REST API
# ------------------------------------------------------------------------------------------------
variable "rest_api_id" {}
# ------------------------------------------------------------------------------------------------
# The API resource ID
# ------------------------------------------------------------------------------------------------
variable "resource_id" {}
# ------------------------------------------------------------------------------------------------
# The ID of the parent API resource
# ------------------------------------------------------------------------------------------------
# variable "parent_id" {}
# ------------------------------------------------------------------------------------------------
# The last path segment of this API resource.
# ------------------------------------------------------------------------------------------------
# variable "path_part" {}
# ------------------------------------------------------------------------------------------------
# The HTTP Method (GET, POST, PUT, DELETE, HEAD, OPTIONS, ANY)
# ------------------------------------------------------------------------------------------------
variable "http_method" {
  default = "GET"
}
# ------------------------------------------------------------------------------------------------
# The type of authorization used for the method (NONE, CUSTOM, AWS_IAM, COGNITO_USER_POOLS)
# ------------------------------------------------------------------------------------------------
variable "authorization" {
  default = "NONE"
}
# ------------------------------------------------------------------------------------------------
# The authorizer id to be used when the authorization is CUSTOM or COGNITO_USER_POOLS
# ------------------------------------------------------------------------------------------------
variable "authorizer_id" {
  default = null
}
# ------------------------------------------------------------------------------------------------
# The authorization scopes used when the authorization is COGNITO_USER_POOLS
# ------------------------------------------------------------------------------------------------
variable "authorization_scopes" {
  default = null
}
# ------------------------------------------------------------------------------------------------
# Specify if the method requires an API key
# ------------------------------------------------------------------------------------------------
variable "api_key_required" {
  default = false
}
# ------------------------------------------------------------------------------------------------
# A map of the API models used for the request's content type where key is the content type
# (e.g. application/json) and value is either Error,
# Empty (built-in models) or aws_api_gateway_model's name.
# ------------------------------------------------------------------------------------------------
variable "request_models" {
  default = null
}
# ------------------------------------------------------------------------------------------------
# The ID of a aws_api_gateway_request_validator
# ------------------------------------------------------------------------------------------------
variable "request_validator_id" {
  default = null
}
# ------------------------------------------------------------------------------------------------
# A map of request parameters (from the path, query string and headers) that should be passed to the integration. 
# The boolean value indicates whether the parameter is required (true) or optional (false). 
# For example: request_parameters = {"method.request.header.X-Some-Header" = true "method.request.querystring.some-query-param" = true} 
# would define that the header X-Some-Header and the query string some-query-param must be provided in the request.
# ------------------------------------------------------------------------------------------------
variable "request_parameters" {
  type    = map(bool)
  default = null
}
# ------------------------------------------------------------------------------------------------
# Lambda Function URI
# ------------------------------------------------------------------------------------------------
variable "lambda_function_uri" {
  default = null
}
