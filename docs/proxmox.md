# Proxmox

Using Proxmox `9.1.x` on **x86-based** macminis

## Pre-steps
1. On later macmini versions, disable `T2` chip security to be able to [override the OS + boot from Proxmox install USB](https://forum.proxmox.com/threads/installing-proxmox-ve-7-2-on-a-mac-mini-2018.114218/)
1. Download [Proxmox ISO](https://www.proxmox.com/en/downloads) and burn file to USB disk, I'm using [Balena Etcher](https://etcher.balena.io/)


## Post-installation provisioning:

1. Install manually, on each Proxmox **node**, scripts from [Proxmox VE Helper-Scripts](https://community-scripts.github.io/ProxmoxVE/)
  **NOTE**: Install directly on each node from Proxmox GUI `Shell`, DON'T SSH!
  - [PVE Post Install](https://community-scripts.github.io/ProxmoxVE/scripts?id=post-pve-install&category=Proxmox+%26+Virtualization) –– keep most defaults but **DON'T disable High Availability**, we will create a cluster later!?!

2. Enable **LetsEncrypt certificates** to avoid SSL warnings on web GUI:
   [https://www.smarthomebeginner.com/proxmox-ssl-certificate-with-letsencrypt/](https://www.smarthomebeginner.com/proxmox-ssl-certificate-with-letsencrypt/)

3. Enable **global NFS share** from web GUI:
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

4. Get a hold of node's private SSH key and append it to your local SSH config
   _hint_: Use `user` + `password` provided to Proxmox during installation also for initial SSH
   ```shell
   # Run from your local workstation, update "NODE" values appropriately
   ssh user@NODE "cat /root/.ssh/id_rsa" > ~/.ssh/personal/NODE_rsa
   chmod 0600 ~/.ssh/personal/NODE_rsa
   cat <<EOF >> ~/.ssh/personal/config

   Host NODE NODE.fqdn
     User root
     Hostname NODE_IP
     IdentityFile ~/.ssh/personal/NODE_rsa
   EOF
   ```

5. Append `termix` SSH key to Proxmox node authorized keys file:
   ```shell
   # Run from Proxmox node shell
   echo "ssh-ed25519 AAA..." >> /root/.ssh/authorized_keys
   ```

6. Run Ansible playbook with base configurations:
  ```shell
  task proxmox:provision-nodes
  ```

7. Download CT/LXC templates via GUI:
   `Node` > `local (XYZ)` > `CT Templates` > `Templates`
   Look for:
   - `ubuntu-24-04-standard` (Noble)

8. Create **cluster** from web GUI:
   `Datacenter` > `Cluster` > `Create Cluster`
   Choose "192.168.136.100" network
   Use `Join Information` to get the token needed by other nodes to join
