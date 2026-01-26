resource "proxmox_lxc" "lxc" {
  target_node = var.target_node

  hostname        = local.hostname
  description     = <<-EOT
    # ${local.description}

    |            |                                      |
    | ---------- |--------------------------------------|
    | hostname   | `${local.hostname}`                  |
    | ip         | `${local.network.ip}`                |
    | cores      | `${local.cores}`                     |
    | memory     | `${local.memory} MB`                 |
    | root disk  | `${local.rootfs.size}`               |
    | dns        | `${join(", ", var.dns_aliases)}`     |
    | mnt points | `${join(", ", var.mountpoint.*.mp)}` |

    ![LXC](https://cdn.jsdelivr.net/gh/selfhst/icons@main/svg/linux-containers-lxc.svg)
  EOT
  cores           = local.cores
  memory          = local.memory
  onboot          = local.onboot
  ostemplate      = local.ostemplate
  ssh_public_keys = local.ssh_public_keys
  start           = local.start
  unprivileged    = local.unprivileged
  tags            = local.tags

  rootfs {
    storage = local.rootfs.storage
    size    = local.rootfs.size
  }

  dynamic "mountpoint" {
    for_each = var.mountpoint == null ? [] : var.mountpoint
    content {
      key     = tostring(mountpoint.key)
      slot    = mountpoint.key
      storage = "local-lvm"
      mp      = mountpoint.value["mp"]
      size    = mountpoint.value["size"]
    }
  }

  network {
    name     = local.network.name
    bridge   = local.network.bridge
    firewall = local.network.firewall
    gw       = local.network.gw
    ip       = local.network.ip
  }

  features {
    keyctl  = local.features.keyctl
    nesting = local.features.nesting
  }
}
