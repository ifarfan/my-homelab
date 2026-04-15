resource "proxmox_virtual_environment_vm" "vm_template" {
  name      = "${local.name}.${var.cloudflare_domain}"
  node_name = local.node

  agent {
    enabled = local.agent_enabled
  }

  cpu {
    cores = local.cpu_cores
  }

  memory {
    dedicated = local.memory_dedicated
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${local.network.ip}/24"
        gateway = local.network.gw
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.userdata_cloudconfig.id
  }

  disk {
    datastore_id = local.disk.datastore_id
    file_id      = local.disk.file_id
    interface    = local.disk.interface
    iothread     = local.disk.iothread
    discard      = local.disk.discard
    size         = local.disk.size
  }

  network_device {
    bridge = local.network.bridge
  }
}

resource "proxmox_virtual_environment_file" "userdata_cloudconfig" {
  content_type = "snippets"
  datastore_id = local.nfs_datastore_id
  node_name    = local.node

  source_raw {
    data      = local.user_data
    file_name = local.user_file
  }
}
