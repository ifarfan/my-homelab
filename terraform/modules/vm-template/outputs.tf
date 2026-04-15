output "vm_id" {
  description = "VM ID"
  value       = proxmox_virtual_environment_vm.vm_template.vm_id
}

output "vm_proxmox_node" {
  description = "VM Proxmox Node"
  value       = "${var.proxmox_node}.${var.cloudflare_domain}"
}

output "vm_hostname" {
  description = "VM Hostname"
  value       = "${var.hostname}.${var.cloudflare_domain}"
}

output "vm_ip" {
  description = "VM IP address"
  value       = var.ip
}
