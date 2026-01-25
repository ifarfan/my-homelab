locals {
  hostname     = "arrs"
  description  = "*Arrs LXC"
  cores        = 4
  memory       = 8192
  onboot       = true
  unprivileged = false # privileged = true
  tags         = "apps"
  ip           = "192.168.136.36"

  # Disks
  rootfs_size = "30G"
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
    "bazarr",
    "flaresolverr",
    "lazylibrarian",
    "lidarr",
    "metube",
    "prowlarr",
    "qbittorrent",
    "radarr",
    "sonarr",
    "stash",
    "traefik-${local.hostname}",
    "whisparr",
  ]
}
