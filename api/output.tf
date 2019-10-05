# ------------------------------------------------------------
# REST API - id
# The ID of the REST API
# ------------------------------------------------------------
output "id" {
  value = aws_api_gateway_rest_api.this.id
}

# ------------------------------------------------------------
# REST API - root_resource_id
# The resource ID of the REST API's root
# ------------------------------------------------------------
output "root_resource_id" {
  value = aws_api_gateway_rest_api.this.root_resource_id
}

# ------------------------------------------------------------
# REST API - created_date
# The creation date of the REST API
# ------------------------------------------------------------
output "created_date" {
  value = aws_api_gateway_rest_api.this.created_date
}

# ------------------------------------------------------------
# REST API - execution_arn
# The execution ARN part to be used in lambda_permission's source_arn when allowing API Gateway to invoke a Lambda function
# e.g. arn:aws:execute-api:eu-west-2:123456789012:z4675bid1j, which can be concatenated with allowed stage, method and resource path.
# ------------------------------------------------------------
output "execution_arn" {
  value = aws_api_gateway_rest_api.this.execution_arn
}

# ------------------------------------------------------------
# authorizer_id
# ------------------------------------------------------------
output "authorizer_id" {
  value = aws_api_gateway_authorizer.this[0].id
}

