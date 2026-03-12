locals {
  name        = "${var.hostname}.${var.cloudflare_domain}"
  description = var.description
  clone       = "ubuntu-24-04-tmpl"

  agent              = 1 # QEMU agents
  bios               = "seabios"
  boot               = "order=scsi0"
  ipconfig           = "ip=${var.ip}/24,gw=192.168.136.1"
  memory             = var.memory
  os_type            = "ubuntu"
  protection         = false # can be deleted
  scsihw             = "virtio-scsi-single"
  sshkeys            = join("\n", data.github_user.my_username.ssh_keys)
  start_at_node_boot = true
  tags               = var.tags == "" ? "terraform" : "${var.tags};terraform"
  vm_state           = "running"

  cpu = {
    cores = var.cores
    type  = "host"
  }

  vga = {
    type   = "qxl"
    memory = 32
  }

  network = {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
    mtu    = 1
  }

  disk = {
    iothread = true
    size     = var.rootfs_size
    slot     = "scsi0"
    storage  = "local-lvm",
    type     = "disk"
  }
}
