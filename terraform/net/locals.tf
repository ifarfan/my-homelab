locals {
  hostname     = "net"
  description  = "net LXC"
  cores        = 2
  memory       = 2048
  onboot       = true
  unprivileged = false # privileged = true
  tags         = "network"
  ip           = "192.168.136.30"

  # Disks
  rootfs_size = "10G"
  mountpoint = [
    {
      mp   = "/var/lib/docker"
      size = "8G"
    },
    {
      mp   = "/opt"
      size = "8G"
    }
  ]

  # Launch in this Proxmox node
  target_node = "m0"

  # Additional DNS aliases/CNAMEs
  dns_aliases = [
  ]
}
