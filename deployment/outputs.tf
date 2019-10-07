# ------------------------------------------------------------------------------------------------
# The ID of the stage
# ------------------------------------------------------------------------------------------------
output "stage_id" {
  value = aws_api_gateway_stage.this.id
}
# ------------------------------------------------------------------------------------------------
# The URL to invoke the API pointing to the stage
# e.g. https://z4675bid1j.execute-api.eu-west-2.amazonaws.com/prod
# ------------------------------------------------------------------------------------------------
output "invoke_url" {
  value = aws_api_gateway_stage.this.invoke_url
}
# ------------------------------------------------------------------------------------------------
# The execution ARN to be used in lambda_permission's source_arn when allowing API Gateway to invoke a Lambda function
# e.g. arn:aws:execute-api:eu-west-2:123456789012:z4675bid1j/prod
# ------------------------------------------------------------------------------------------------
output "execution_arn" {
  value = aws_api_gateway_stage.this.execution_arn
}
# ------------------------------------------------------------------------------------------------
# The ID of the deployment
# ------------------------------------------------------------------------------------------------
output "deployment_id" {
  value = aws_api_gateway_deployment.this[0].id
}
# ------------------------------------------------------------------------------------------------
# The creation date of the deployment
# ------------------------------------------------------------------------------------------------
output "created_date" {
  value = aws_api_gateway_deployment.this[0].created_date
}
# ------------------------------------------------------------------------------------------------
# The upload date associated with the domain certificate.
# ------------------------------------------------------------------------------------------------
output "certificate_upload_date" {
  value = aws_api_gateway_deployment.this[0].created_date
}
# ------------------------------------------------------------------------------------------------
# The hostname created by Cloudfront to represent the distribution that implements this domain name mapping.
# ------------------------------------------------------------------------------------------------
output "cloudfront_domain_name" {
  value = aws_api_gateway_domain_name.this[0].cloudfront_domain_name
}
# ------------------------------------------------------------------------------------------------
# For convenience, the hosted zone ID (Z2FDTNDATAQYW2) that can be used to create a Route53 alias record for the distribution.
# ------------------------------------------------------------------------------------------------
output "cloudfront_zone_id" {
  value = aws_api_gateway_domain_name.this[0].cloudfront_zone_id
}
# ------------------------------------------------------------------------------------------------
# The hostname for the custom domain's regional endpoint.
# ------------------------------------------------------------------------------------------------
output "regional_domain_name" {
  value = aws_api_gateway_domain_name.this[0].regional_domain_name
}
# ------------------------------------------------------------------------------------------------
# The hosted zone ID that can be used to create a Route53 alias record for the regional endpoint.
# ------------------------------------------------------------------------------------------------
output "regional_zone_id" {
  value = aws_api_gateway_domain_name.this[0].regional_zone_id
}
