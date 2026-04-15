provider "proxmox" {
  endpoint = var.proxmox_url
  username = var.proxmox_user
  password = var.proxmox_password
  insecure = true
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
