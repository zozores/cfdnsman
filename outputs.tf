output "record_ids" {
  description = "The IDs of the created DNS records"
  value       = { for k, v in cloudflare_record.record : k => v.id }
}

output "record_hostnames" {
  description = "The hostnames of the created DNS records"
  value       = { for k, v in cloudflare_record.record : k => v.hostname }
}
