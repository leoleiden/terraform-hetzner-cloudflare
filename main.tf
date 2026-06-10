# Automatically generate an SSH key via Terraform
resource "tls_private_key" "ssh_key" {
  algorithm = "ED25519"
}

# Add the generated SSH key to your Hetzner account
resource "hcloud_ssh_key" "default" {
  name       = "terraform-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Provision the Hetzner server (CX11 instance)
resource "hcloud_server" "web" {
  name        = "prod-web-server"
  image       = "ubuntu-24.04"
  server_type = "cx23"
  location    = "nbg1"
  ssh_keys    = [hcloud_ssh_key.default.id]

  # cloud-init script to install and start Nginx automatically
  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    echo "<h1>Hetzner + Cloudflare Infrastructure Powered by Terraform</h1><p>Deployed by Leonid Lachmann</p>" > /var/www/html/index.html
    systemctl enable nginx
    systemctl start nginx
  EOF
}