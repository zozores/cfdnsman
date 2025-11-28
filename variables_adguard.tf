variable "adguard_host" {
  description = "AdGuard Home host"
  type        = string
}

variable "adguard_username" {
  description = "AdGuard Home username"
  type        = string
}

variable "adguard_password" {
  description = "AdGuard Home password"
  type        = string
  sensitive   = true
}

variable "adguard_scheme" {
  description = "AdGuard Home scheme (http or https)"
  type        = string
  default     = "http"
}


variable "adguard_rewrites" {
  description = "List of AdGuard Home DNS rewrites"
  type = list(object({
    domain = string
    answer = string
  }))
  default = []
}
