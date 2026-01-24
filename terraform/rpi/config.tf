provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

terraform {
  backend "local" {}
}
