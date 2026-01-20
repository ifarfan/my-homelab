locals {
  # ? LXC machine
  hostname        = "${var.hostname}.${var.cloudflare_domain}"
  description     = var.description
  cores           = var.cores
  memory          = var.memory
  onboot          = var.onboot
  ostemplate      = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  ssh_public_keys = join("\n", data.github_user.my_username.ssh_keys)
  start           = true
  unprivileged    = var.unprivileged
  tags            = var.tags == "" ? "terraform" : "${var.tags};terraform"

  rootfs = {
    size    = var.rootfs_size
    storage = "local-lvm"
  }

  network = {
    name     = "eth0"
    bridge   = "vmbr0"
    firewall = true
    gw       = "192.168.136.1"
    ip       = "${var.ip}/32"
  }

  features = {
    keyctl  = true
    nesting = true
  }
}
