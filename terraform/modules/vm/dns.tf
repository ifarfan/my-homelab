resource "cloudflare_record" "dns_record" {
  zone_id = lookup(data.cloudflare_zones.domain_zone.zones[0], "id")
  name    = var.hostname
  content = var.ip
  type    = "A"
  ttl     = 1 # auto
}

resource "cloudflare_record" "cname_records" {
  for_each = toset(var.dns_aliases)

  zone_id = lookup(data.cloudflare_zones.domain_zone.zones[0], "id")
  name    = each.value
  content = "${var.hostname}.${var.cloudflare_domain}"
  type    = "CNAME"
  ttl     = 1 # auto
}
