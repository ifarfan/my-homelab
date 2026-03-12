terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      # version = "~>2.9.0"
      version = "3.0.2-rc07"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      # version = "~> 3.0"
      version = "~> 4.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.10"
    }
  }
}
