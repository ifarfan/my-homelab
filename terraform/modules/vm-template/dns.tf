resource "cloudflare_record" "dns_record" {
  zone_id = lookup(data.cloudflare_zones.domain_zone.zones[0], "id")
  name    = var.hostname
  content = var.ip
  type    = "A"
  ttl     = 1 # auto
}
