# My-Homelab
Documenting my `homelab` journey

- Configure + manage **Proxmox** nodes via `Ansible`
- Create VMs + LXC containers via `Terraform`
- Manage VMs + LXC containers via `Ansible`
- Create VM templates via `Packer`

### Hardware
Currently running `1` macminis as a `Proxmox` cluster

```shell
m0:
  Model:  Macmini8,1
  Memory: 64GB
  CPU:    12 logical / 6 CPUs x Intel(R) Core(TM) i7-8700B CPU @ 3.2GHz
  Disk:   512GB SSD
  IP:     192.168.136.10
```

### Runbooks
1. All operations have been encapsulated into **tasks**:
   ```shell
   # From repo root
   task --list
   ```

### Notes
1. Enable LetsEncrypt certificates for Proxmox nodes:
   [https://www.smarthomebeginner.com/proxmox-ssl-certificate-with-letsencrypt/](https://www.smarthomebeginner.com/proxmox-ssl-certificate-with-letsencrypt/)
