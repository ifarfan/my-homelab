# My-Homelab
Documenting my `homelab` journey using a `Proxmox` cluster running, primarily, LXC containers and some VMs. Using `IaC`, as much as possible, for reproducibility and for general automation. Also using some Raspberry Pis for some extra fun and games.

*Grosso modo*,
- Configure + manage **Proxmox** nodes via `Ansible`
- Create VMs + LXC containers via `Terraform`
- Manage VMs + LXC containers via `Ansible`
- Also manage Raspberry Pis via `Ansible`
- Create VM templates via `Packer`
- All recurring operations encapsulated via `task`:
   ```shell
   # From repo root
   task --list
   ```

## Docs
1. [Hardware](docs/hardware.md) used + general [network](docs/network.md) layout
1. [Proxmox](docs/proxmox.md) notes + configuration steps
1. [Raspberry Pis](docs/rpi.md) setup + configuration
1. Using [Task](docs/task.md) for encapsulating all jobs/scripts/work
1. [Terraform](docs/terraform.md) for launching LXCs & VMs
1. [Ansible](docs/ansible.md) for configuring LXCs & VMs and miscellaneous orchestration tasks
1. [Packer](docs/packer.md) for creating VM templates
