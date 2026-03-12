output "vm_full_id" {
  description = "VM Proxmox node/type/vmID"
  value       = proxmox_vm_qemu.vm.id
}

output "vm_vmid" {
  description = "VM Proxmox vmID"
  value       = proxmox_vm_qemu.vm.vmid
}

output "vm_proxmox_node" {
  description = "VM Proxmox Node"
  value       = "${proxmox_vm_qemu.vm.target_node}.${var.cloudflare_domain}"
}

output "vm_hostname" {
  description = "VM Proxmox Hostname"
  value       = proxmox_vm_qemu.vm.name
}

output "vm_ip" {
  description = "VM IP address"
  value       = var.ip
}
