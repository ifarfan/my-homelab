resource "cloudflare_record" "dns_record" {
  zone_id = lookup(data.cloudflare_zones.domain_zone.zones[0], "id")
  name    = local.name
  content = local.network.ip
  type    = "A"
  ttl     = 1 # auto
}
