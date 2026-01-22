locals {
  hostname     = "devbox"
  description  = "Devbox LXC"
  cores        = 6
  memory       = 12288
  onboot       = true
  unprivileged = false # privileged = true
  tags         = "dev"
  ip           = "192.168.136.32"

  # Disks
  rootfs_size = "30G"
  mountpoint = [
    {
      mp   = "/var/lib/docker"
      size = "20G"
    }
  ]

  # Launch in this Proxmox node
  target_node = "m0"

  # Additional DNS aliases/CNAMEs
  dns_aliases = [
  ]
}
