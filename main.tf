locals {
  # Flatten the map of zones and records into a single map of records
  # Key format: "zone_key.record_key"
  records = merge([
    for zone_key, zone in var.zones : {
      for record_key, record in zone.records :
      "${zone_key}.${record_key}" => merge(record, {
        zone_id = zone.zone_id
      })
    }
  ]...)
}

provider "adguard" {
  host     = var.adguard_host
  username = var.adguard_username
  password = var.adguard_password
  scheme   = var.adguard_scheme
}

resource "adguard_rewrite" "rewrite" {
  for_each = { for rewrite in var.adguard_rewrites : rewrite.domain => rewrite }

  domain = each.value.domain
  answer = each.value.answer
}

resource "cloudflare_record" "record" {
  for_each = local.records

  zone_id  = each.value.zone_id
  name     = each.value.name
  value    = each.value.value
  type     = each.value.type
  ttl      = each.value.ttl
  proxied  = each.value.proxied
  priority = each.value.priority
  comment  = "Managed by Terraform"
}
