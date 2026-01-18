data "cloudflare_zones" "domain_zone" {
  filter {
    name = var.cloudflare_domain
  }
}
