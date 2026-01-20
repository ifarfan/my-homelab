output "lxc_full_id" {
  description = "LXC Proxmox node/type/vmID"
  value       = proxmox_lxc.lxc.id
}

output "lxc_vmid" {
  description = "LXC Proxmox vmID"
  value       = proxmox_lxc.lxc.vmid
}

output "lxc_node" {
  description = "LXC Proxmox Node"
  value       = "${proxmox_lxc.lxc.target_node}.${var.cloudflare_domain}"
}

output "lxc_hostname" {
  description = "LXC Hostname"
  value       = proxmox_lxc.lxc.hostname
}

output "lxc_ip" {
  description = "LXC IP address"
  value       = var.ip
}
