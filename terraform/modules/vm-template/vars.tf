# Fetch values from terraform.tfvars
variable "proxmox_url" {
  type = string
}

variable "proxmox_user" {
  type = string
}

variable "proxmox_password" {
  type      = string
  sensitive = true
}

variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}

variable "cloudflare_domain" {
  type = string
}

variable "github_username" {
  type = string
}

# VM-specific variables
variable "hostname" {
  type    = string
  default = "template"
}

variable "description" {
  type = string
}

variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 2048
}

variable "tags" {
  type    = string
  default = ""
}

variable "ip" {
  type = string
}

variable "disk_size" {
  type    = string
  default = "20"
}

variable "proxmox_node" {
  type    = string
  default = "m0"
}
