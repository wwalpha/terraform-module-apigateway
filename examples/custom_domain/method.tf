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
