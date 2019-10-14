# ------------------------------------------------------------------------------------------------
# The resource's identifier.
# ------------------------------------------------------------------------------------------------
output "id" {
  value = aws_api_gateway_resource.this.id
}
# ------------------------------------------------------------------------------------------------
# The complete path for this API resource, including all parent paths.
# ------------------------------------------------------------------------------------------------
output "path" {
  value = aws_api_gateway_resource.this.path
}
# ------------------------------------------------------------------------------------------------
# The complete path for this API resource, including all parent paths.
# ------------------------------------------------------------------------------------------------
output "cors_integration_id" {
  value = aws_api_gateway_integration.this[0].id
}
