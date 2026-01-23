locals {
  hostname     = "tools"
  description  = "Tools LXC"
  cores        = 4
  memory       = 8192
  onboot       = true
  unprivileged = false # privileged = true
  tags         = "tools"
  ip           = "192.168.136.34"

  # Disks
  rootfs_size = "20G"
  mountpoint = [
    {
      mp   = "/var/lib/docker"
      size = "8G"
    },
    {
      mp   = "/opt"
      size = "20G"
    }
  ]

  # Launch in this Proxmox node
  target_node = "m0"

  # Additional DNS aliases/CNAMEs
  dns_aliases = [
    "traefik-${local.hostname}",
  ]
}
