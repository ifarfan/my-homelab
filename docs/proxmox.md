# Proxmox

Using Proxmox `9.1.x` on **x86-based** macminis

## Pre-steps
1. On later macmini versions, disable `T2` chip security to be able to [override the OS + boot from Proxmox install USB](https://forum.proxmox.com/threads/installing-proxmox-ve-7-2-on-a-mac-mini-2018.114218/)
1. Download [Proxmox 9x and Proxmox Backup Server 4.x](https://www.proxmox.com/en/downloads) installers and burn files to USB disks; I'm using [Balena Etcher](https://etcher.balena.io/)


## Post-installation:

1. On first boot, Proxmox GUI available at:
     - **Proxmox Nodes**: `https://NODE_IP_ADDRESS:8006/`
1. Install manually, on each Proxmox **node**, scripts from [Proxmox VE Helper-Scripts](https://community-scripts.github.io/ProxmoxVE/)
     **NOTE**: Install directly on each node from Proxmox GUI `Shell`, DON'T SSH!
     - [PVE Post Install](https://community-scripts.github.io/ProxmoxVE/scripts?id=post-pve-install&category=Proxmox+%26+Virtualization) –– run on **Proxmo Server** nodes, keep most defaults but **DON'T disable High Availability**, we will create a cluster later!?! –– will prompt for a reboot
1. Add secondary network card, via Proxmox GUI, under `Node` > `Network`:
      - Note name of 2nd network card (i.e., `ens9`)
      - `Create` Linux Bridge as `vmbr1`
      - Use new IP address (i.e., `192.168.136.5x/24`) and use 2nd network card name for `Bridge ports`
      - Click `Create`
      - Click `Apply Configuration`
1. Get a hold of each node's private SSH key and append it to your local SSH config

   _hint_: Use `user` + `password` provided to Proxmox during installation for initial SSH
      ```shell
      # Run from your local workstation, update "NODE" values appropriately (i.e., m0, m1...)
      ssh user@NODE "cat /root/.ssh/id_rsa" > ~/.ssh/personal/NODE_rsa
      chmod 0600 ~/.ssh/personal/NODE_rsa
      cat <<EOF >> ~/.ssh/personal/config

      Host NODE NODE.fqdn
      User root
      Hostname NODE_IP
      IdentityFile ~/.ssh/personal/NODE_rsa
      EOF
      ```
1. Append `termix` SSH key to Proxmox node authorized keys file:
   ```shell
   # Run from Proxmox node shell
   echo "ssh-ed25519 AAA..." >> /root/.ssh/authorized_keys
   ```
1. Download CT/LXC templates via GUI:
   `Node` > `local (XYZ)` > `CT Templates` > `Templates`
   Look for:
   - `ubuntu-24-04-standard` (Noble)


## Post-installation (Proxmox Backup Server):
1. On first boot, Proxmox GUI available at:
     - **Proxmox Backup Server**: `https://NODE_IP_ADDRESS:8007/`
1. Install manually script(s) from [Proxmox VE Helper-Scripts](https://community-scripts.github.io/ProxmoxVE/)
      **NOTE**: Install directly on each node from Proxmox GUI `Shell`, DON'T SSH!
      - [PBS Post Install](https://community-scripts.github.io/ProxmoxVE/scripts?id=post-pbs-install) –– keep defaults, will prompt for a reboot
1. Copy your SSH key and Termix SSH key to PBS node
      ```shell
      cat <<EOF >> /root/.ssh/authorized_keys
      ssh-ed25519 AA...
      ssh-ed25519 AA...
      EOF
      chmod 0600 /root/.ssh/authorized_keys
      ```
1. Enable **LetsEncrypt certificates** to avoid SSL warnings on Proxmox GUI:
   [https://www.smarthomebeginner.com/proxmox-ssl-certificate-with-letsencrypt/](https://www.smarthomebeginner.com/proxmox-ssl-certificate-with-letsencrypt/)
     On PBS GUI, it's under:
     `Configuration` > `Certificates` > `ACME`
1. Run Ansible playbook with base configurations:
    ```shell
    task proxmox:provision-pbs
    ```


## Cluster provisioning:

1. Pick `1st node` and execute next steps from its **Proxmox GUI**
1. Enable **LetsEncrypt certificates** to avoid SSL warnings on Proxmox GUI:
   [https://www.smarthomebeginner.com/proxmox-ssl-certificate-with-letsencrypt/](https://www.smarthomebeginner.com/proxmox-ssl-certificate-with-letsencrypt/)
1. Enable **global NFS share** from Proxmox GUI:
   `Datacenter` > `Storage` > `Add` > `NFS`
      ```shell
      ID: NAS_NAME-nfs
      Server: NAS IP
      Export: /volume1/proxmox
      Content:
      - Disk image
      - ISO image
      - Backups
      - Snippets
      - Import
      NFS Version: 4.1
      ```
1. Create **Cluster** from Proxmox GUI on `1st node`:
   `Datacenter` > `Cluster` > `Create Cluster`
   Choose `192.168.136.5x` network
   Click on `Join Information` to get the token needed for other nodes to join
1. Repeat steps on each other node:
   `Datacenter` > `Cluster` > `Join Cluster`
     - Use `Join Information` from previous step
     - Type node `password`
     - Use 2nd network under **Cluster Network**: `link:0` `192.168.136.5x`
1. Run Ansible playbook with base configurations
     **NOTE**: Ansible inventory will ONLY work once all nodes are part of cluster
      ```shell
      task proxmox:provision-nodes
      ```
