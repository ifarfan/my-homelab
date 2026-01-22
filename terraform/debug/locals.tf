locals {
  hostname     = "debug"
  description  = "Debug LXC"
  cores        = 2
  memory       = 2048
  onboot       = true
  unprivileged = false # privileged = true
  tags         = "dev"
  ip           = "192.168.136.31"

  # Disks
  rootfs_size = "20G"
  mountpoint = [
    {
      mp   = "/var/lib/docker"
      size = "8G"
    }
  ]

  # Launch in this Proxmox node
  target_node = "m0"

  # Additional DNS aliases/CNAMEs
  dns_aliases = [
  ]
}
