terraform {
  required_version = ">= 1.0.0"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

# to Hetzner
provider "hcloud" {
  token = var.hcloud_token
}

# to Cloudflare
provider "cloudflare" {
  api_token = var.cloudflare_api_token
}