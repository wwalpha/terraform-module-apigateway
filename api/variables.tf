# name - (Required) The name of the REST API
variable "api_name" {
}

# description - (Optional) The description of the REST API
variable "api_description" {
  default = null
}

# endpoint_configuration - (Optional) Nested argument defining API endpoint configuration including endpoint type. Defined below.
# Valid values: EDGE, REGIONAL or PRIVATE. If unspecified, defaults to EDGE. Must be declared as REGIONAL in non-Commercial partitions.
variable "api_endpoint_configuration" {
  default = "EDGE"
}

# binary_media_types - (Optional) The list of binary media types supported by the RestApi. By default, the RestApi supports only UTF-8-encoded text payloads.
variable "api_binary_media_types" {
  default = null
}

# minimum_compression_size - (Optional) Minimum response size to compress for the REST API. Integer between -1 and 10485760 (10MB). Setting a value greater than -1 will enable compression, -1 disables compression (default).
variable "api_minimum_compression_size" {
  default = -1
}

# body - (Optional) An OpenAPI specification that defines the set of routes and integrations to create as part of the REST API.
variable "api_body" {
  default = null
}

# policy - (Optional) JSON formatted policy document that controls access to the API Gateway. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide
variable "api_policy" {
  default = null
}

# api_key_source - (Optional) The source of the API key for requests. Valid values are HEADER (default) and AUTHORIZER.
variable "api_key_source" {
  default = "HEADER"
}

# --------------------------------------------------------------------------------------------------------------
# The name of the lambda function.
# --------------------------------------------------------------------------------------------------------------
variable "lambda_function_name" {
  default = null
}

# --------------------------------------------------------------------------------------------------------------
# The name of the authorizer
# --------------------------------------------------------------------------------------------------------------
variable "authorizer_name" {
  default = null
}

variable "cognito_user_pool_name" {
  default = null
}

# (Optional) The source of the identity in an incoming request. Defaults to method.request.header.Authorization. 
# For REQUEST type, this may be a comma-separated list of values, including headers, query string parameters and stage variables
# e.g. "method.request.header.SomeHeaderName,method.request.querystring.SomeQueryStringName,stageVariables.SomeStageVariableName"
variable "authorizer_identity_source" {
  default = "method.request.header.Authorization"
}

# --------------------------------------------------------------------------------------------------------------
# The type of the authorizer. 
# Possible values are TOKEN for a Lambda function using a single authorization token submitted in a custom header, 
# REQUEST for a Lambda function using incoming request parameters, 
# or COGNITO_USER_POOLS for using an Amazon Cognito user pool. Defaults to TOKEN.
# --------------------------------------------------------------------------------------------------------------
variable "authorizer_type" {
  default = "TOKEN"
}

#  (Optional) The credentials required for the authorizer. 
# To specify an IAM Role for API Gateway to assume, use the IAM Role ARN.
variable "authorizer_credentials" {
  default = "TOKEN"
}

# (Optional) The TTL of cached authorizer results in seconds. Defaults to 300.
variable "authorizer_result_ttl_in_seconds" {
  default = 300
}

# --------------------------------------------------------------------------------------------------------------
# A validation expression for the incoming identity. 
# For TOKEN type, this value should be a regular expression. 
# The incoming token from the client is matched against this expression, and will proceed if the token matches. 
# If the token doesn't match, the client receives a 401 Unauthorized response.
# --------------------------------------------------------------------------------------------------------------
variable "authorizer_identity_validation_expression" {
  default = null
}

# --------------------------------------------------------------------------------------------------------------
# (required for type COGNITO_USER_POOLS) A list of the Amazon Cognito user pool ARNs. 
# Each element is of this format: arn:aws:cognito-idp:{region}:{account_id}:userpool/{user_pool_id}.
# --------------------------------------------------------------------------------------------------------------
variable "authorizer_provider_arns" {
  default = null
}

variable "authorizer_role_name" {
  default = null
}

variable "authorizer_policy" {
  default = null
}

variable "stage_name" {
  default = "v1"
}

variable "stage_xray_enabled" {
  default = true
}

# --------------------------------------------------------------------------------------------------------------
# The fully-qualified domain name to register
# --------------------------------------------------------------------------------------------------------------
variable "custom_domain_name" {
  default = null
}

# --------------------------------------------------------------------------------------------------------------
#  Configuration block defining API endpoint information including type.
# --------------------------------------------------------------------------------------------------------------
variable "custom_domain_endpoint_configuration" {
  default = "EDGE"
}

# --------------------------------------------------------------------------------------------------------------
# The ARN for an AWS-managed certificate. AWS Certificate Manager is the only supported source.
# Used when a regional domain name is desired
# --------------------------------------------------------------------------------------------------------------
variable "custom_domain_regional_certificate_arn" {
  default = null
}

variable "custom_domain_base_path" {
  default = "EDGE"
}

