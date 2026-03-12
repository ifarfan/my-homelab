resource "proxmox_vm_qemu" "vm" {
  target_node = var.target_node

  name               = local.name
  clone              = local.clone
  description        = <<-EOT
    # ${local.description}

    |            |                                      |
    | ---------- |--------------------------------------|
    | hostname   | `${local.name}`                      |
    | ipconfig   | `${local.ipconfig}`                  |
    | cores      | `${local.cpu.cores}`                 |
    | memory     | `${local.memory} MB`                 |
    | root disk  | `${local.disk.size}`                 |
    | dns        | `${join(", ", var.dns_aliases)}`     |

    ![Ubuntu](https://cdn.jsdelivr.net/gh/selfhst/icons@main/svg/ubuntu.svg)
  EOT
  agent              = local.agent
  bios               = local.bios
  boot               = local.boot
  ipconfig0          = local.ipconfig
  memory             = local.memory
  os_type            = local.os_type
  protection         = local.protection
  scsihw             = local.scsihw
  sshkeys            = local.sshkeys
  start_at_node_boot = local.start_at_node_boot
  tags               = local.tags
  vm_state           = local.vm_state

  cpu {
    cores = local.cpu.cores
    type  = local.cpu.type
  }

  vga {
    type   = local.vga.type
    memory = local.vga.memory
  }

  network {
    id     = local.network.id
    model  = local.network.model
    bridge = local.network.bridge
    mtu    = local.network.mtu
  }

  disk {
    iothread = local.disk.iothread
    size     = local.disk.size
    slot     = local.disk.slot
    storage  = local.disk.storage
    type     = local.disk.type
  }
}
