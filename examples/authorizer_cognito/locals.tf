locals {
  api_gateway_files = [
    "${filemd5("main.tf")}",
  ]
}
