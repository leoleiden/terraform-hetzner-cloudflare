# Retrieve the Cloudflare zone details for the configured domain
data "cloudflare_zone" "domain" {
  name = var.domain_name
}

# Create an A record pointing the root domain to the Hetzner server IP
resource "cloudflare_record" "www" {
  zone_id = data.cloudflare_zone.domain.id
  name    = "@" # Root domain
  value   = hcloud_server.web.ipv4_address
  type    = "A"
  proxied = true # Enables Cloudflare CDN and WAF (the orange cloud)
}