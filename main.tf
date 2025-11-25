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
