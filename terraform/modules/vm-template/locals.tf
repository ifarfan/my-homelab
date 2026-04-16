locals {
  # Determine if converting to template or creating a VM
  name     = var.convert_to_template == true ? "template-ubuntu-24-04" : "${var.hostname}.${var.cloudflare_domain}"
  template = var.convert_to_template == true ? true : false

  # Other settings
  description = <<-EOT
    # ${var.description}

    |            |                                      |
    | ---------- |--------------------------------------|
    | hostname   | `${var.hostname}`                    |
    | ip         | `${var.ip}`                          |
    | cores      | `${var.cores}`                       |
    | memory     | `${var.memory} GB`                   |
    | root disk  | `${var.disk_size} GB`                |
    | template   | `${var.convert_to_template}`         |

    ![Ubuntu](https://cdn.jsdelivr.net/gh/selfhst/icons@main/svg/ubuntu.svg)
  EOT
  tags        = var.tags == "" ? ["terraform"] : split(",", "${var.tags},terraform")

  agent_enabled    = true
  nfs_datastore_id = "ds1-nfs"

  user = {
    name = "ubuntu"
    keys = data.github_user.my_username.ssh_keys
  }

  disk = {
    datastore_id = "local-lvm"
    file_id      = "${local.nfs_datastore_id}:iso/ubuntu-24.04-minimal-cloudimg-amd64.img"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.disk_size
  }

  network = {
    gw     = "192.168.136.1"
    bridge = "vmbr0"
  }

  user_file = "userdata-cloudconfig-${var.hostname}.yaml"
  user_data = <<-EOF
    #cloud-config
    disable_root: false
    hostname: ${var.hostname}
    keyboard:
      layout: us
    locale: en_US.UTF-8
    package_update: true
    package_upgrade: true
    packages:
      - cloud-init
      - qemu-guest-agent
    power_state:
      delay: now
      mode: reboot
      message: Rebooting after cloud-init completion
      condition: true
    resize_rootfs: true
    runcmd:
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
    ssh_pwauth: false
    timezone: Etc/UTC
    users:
      - default
      - name: ubuntu
        gecos: Ubuntu
        groups: sudo
        lock_passwd: true
        shell: /bin/bash
        ssh_authorized_keys:
          - ${join("\n      - ", local.user.keys)}
        sudo: ALL=(ALL) NOPASSWD:ALL
  EOF
}
