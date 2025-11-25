variable "cloudflare_api_token" {
  description = "The Cloudflare API Token"
  type        = string
  sensitive   = true
}

variable "zones" {
  description = "Map of Cloudflare zones and their DNS records"
  type = map(object({
    zone_id = string
    records = map(object({
      name     = string
      value    = string
      type     = string
      ttl      = optional(number, 1) # 1 = automatic
      proxied  = optional(bool, false)
      priority = optional(number)
    }))
  }))
  default = {}
}
