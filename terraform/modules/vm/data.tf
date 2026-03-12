data "cloudflare_zones" "domain_zone" {
  filter {
    name = var.cloudflare_domain
  }
}

data "github_user" "my_username" {
  username = var.github_username
}
