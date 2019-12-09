output "method_id" {
  value = aws_api_gateway_method.this.id
}
output "integration_id" {
  value = length(aws_api_gateway_integration.lambda) != 0 ? aws_api_gateway_integration.lambda[0].id : null
}
