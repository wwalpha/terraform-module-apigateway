# ------------------------------------------------------------------------------------------------
# The ID of the associated REST API
# ------------------------------------------------------------------------------------------------
variable "rest_api_id" {}
# ------------------------------------------------------------------------------------------------
# The name of the stage. If the specified stage already exists, 
# it will be updated to point to the new deployment. 
# If the stage does not exist, a new one will be created and point to this deployment.
# ------------------------------------------------------------------------------------------------
variable "stage_name" {
  default = "v1"
}
# ------------------------------------------------------------------------------------------------
# The description of the deployment
# ------------------------------------------------------------------------------------------------
variable "description" {
  default = null
}
# ------------------------------------------------------------------------------------------------
# A map that defines variables for the stage
# ------------------------------------------------------------------------------------------------
variable "deployment_variables" {
  default = null
}
# ------------------------------------------------------------------------------------------------
# A map that defines variables for the stage
# ------------------------------------------------------------------------------------------------
variable "deployment_md5" {}
# ------------------------------------------------------------------------------------------------
# Whether active tracing with X-ray is enabled. Defaults to false.
# ------------------------------------------------------------------------------------------------
variable "xray_tracing_enabled" {
  default = true
}
# ------------------------------------------------------------------------------------------------
# A mapping of tags to assign to the resource.
# ------------------------------------------------------------------------------------------------
variable "stage_tags" {
  default = true
}
# ------------------------------------------------------------------------------------------------
# The description of the stage
# ------------------------------------------------------------------------------------------------
variable "stage_description" {
  default = null
}
# ------------------------------------------------------------------------------------------------
# A map that defines the stage variables
# ------------------------------------------------------------------------------------------------
variable "stage_variables" {
  default = null
}
# ------------------------------------------------------------------------------------------------
# destination_arn: ARN of the log group to send the logs to. Automatically removes trailing :* if present.
# format         : The formatting and values recorded in the logs
# ------------------------------------------------------------------------------------------------
variable "access_log_settings" {
  type    = map(string)
  default = {}
}
# ------------------------------------------------------------------------------------------------
# Specifies whether a cache cluster is enabled for the stage
# ------------------------------------------------------------------------------------------------
variable "cache_cluster_enabled" {
  default = false
}
# ------------------------------------------------------------------------------------------------
# The size of the cache cluster for the stage, if enabled. 
# Allowed values include 0.5, 1.6, 6.1, 13.5, 28.4, 58.2, 118 and 237.
# ------------------------------------------------------------------------------------------------
variable "cache_cluster_size" {
  default = null
}
# ------------------------------------------------------------------------------------------------
# The identifier of a client certificate for the stage.
# ------------------------------------------------------------------------------------------------
variable "client_certificate_id" {
  default = null
}
# ------------------------------------------------------------------------------------------------
# The version of the associated API documentation
# ------------------------------------------------------------------------------------------------
variable "documentation_version" {
  default = null
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
  default = null
}
