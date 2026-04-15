resource "proxmox_virtual_environment_vm" "vm_template" {
  name        = "${var.hostname}.${var.cloudflare_domain}"
  node_name   = var.proxmox_node
  description = local.description
  tags        = local.tags

  agent {
    enabled = local.agent_enabled
  }

  cpu {
    cores = var.cores
  }

  memory {
    dedicated = var.memory
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${var.ip}/24"
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
  node_name    = var.proxmox_node

  source_raw {
    data      = local.user_data
    file_name = local.user_file
  }
}
