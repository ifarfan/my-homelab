# Fetch values from *.auto.tfvars
variable "proxmox_api_url" {
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

# User-defined variables
variable "hostname" {
  type = string
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
  default = 4096
}

variable "onboot" {
  type    = bool
  default = true
}

variable "unprivileged" {
  type    = bool
  default = true
}

variable "tags" {
  type    = string
  default = ""
}

variable "ip" {
  type = string
}

variable "rootfs_size" {
  type    = string
  default = "10G"
}

variable "mountpoint" {
  type = list(object({
    mp   = string
    size = string
  }))
  default = null
}

# Proxmox overwriteable values
variable "target_node" {
  type    = string
  default = "m0"
}

variable "dns_aliases" {
  type    = list(any)
  default = null
}
