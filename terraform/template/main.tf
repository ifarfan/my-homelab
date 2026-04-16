terraform {
  backend "local" {}
}

module "my_vm_template" {
  source = "../modules/vm-template"

  # ? Secrets
  proxmox_url          = var.proxmox_url
  proxmox_user         = var.proxmox_user
  proxmox_password     = var.proxmox_password
  cloudflare_api_token = var.cloudflare_api_token
  cloudflare_domain    = var.cloudflare_domain
  github_username      = var.github_username

  # ? VM Settings
  hostname     = "template"
  description  = "VM Template for Ubuntu 24.04"
  cores        = 2
  ip           = "192.168.136.100"
  memory       = 2048
  disk_size    = 20
  proxmox_node = "m3"
  tags         = "template,ubuntu"

  # Whether to convert the VM to a template after creation
  convert_to_template = var.convert_to_template
}

output "my_vm_template" {
  value = module.my_vm_template
}
