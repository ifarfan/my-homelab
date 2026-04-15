locals {
  name = "template"
  node = "m3"

  agent_enabled    = true
  cpu_cores        = 2
  memory_dedicated = 2048
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
    size         = 20
  }

  network = {
    ip     = "192.168.136.100"
    gw     = "192.168.136.1"
    bridge = "vmbr0"
  }

  user_file = "userdata-cloudconfig-${local.name}.yaml"
  user_data = <<-EOF
    #cloud-config
    disable_root: false
    hostname: ${local.name}
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
