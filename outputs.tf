# Output the public IP address of the newly created server
output "server_ip" {
  value       = hcloud_server.web.ipv4_address
  description = "Public IP address of the Hetzner server"
}

# Output the final accessible URL
output "website_url" {
  value       = "https://${var.domain_name}"
  description = "The URL of the deployed website"
}