terraform {
  required_version = ">= 1.0.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    adguard = {
      source  = "gmichels/adguard"
      version = "1.6.2"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
