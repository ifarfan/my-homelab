# Raspberry Pis

Running `2` RPis as local DNS servers, running `AdGuard` (network blocking) and `Unbound` (for DNS-over-TLS) –– splurged on `High Endurance` SD cards for longer disk lifespan


### Pre-Steps: OS Installation Steps on SD cards
1. Download and install [Raspberry Pi Imager](https://www.raspberrypi.com/software/)] to flash OS to each RPi
1. Run installer with the following choices:
   - Device: `Raspberry Pi 5`
   - OS: `Other General Purpose` > `Ubuntu` > `Ubuntu Server 24.04.x LTS (64-bit)`
   - Storage: `Generic STORAGE DEVICE media`
   - Customization:
     - Hostname: `rpiX` (where `X` is the RPI incremental number for this device)
     - Location:
       - Capital city: `Washington, D.C. (United States)`
       - Time zone: `America/New_York` (note: will be changed to `UTC` during provisioning)
       - Keyboard layout: `us`
    - User:
       - Username: stored at password manager
       - Password: stored at password manager
    - Wi-Fi: skip
    - Remote access:
        - Enable SSH: `on`
        - Authentication mechanism: `Use public key authentication`
        - SSH keys: pick user keys off your Github user and/or stored at password manager
1. Select final `Write` prompt, confirm final disk-erase warning and enter local user password when prompted; wait for SD card to be ready
1. Profit!


## General Configuration

### Code Updates
When a new RPi is added, their host information needs to be added to the repo:
1. `Terraform`:
    1. Add their info to the `local.rpis` list dictionary in the [rpi file](../terraform/rpi/vars.tf), where `hostname` and `ip` are the values that will be used to add them to the domain (notice pre-existing RPis)
    1. Run `task proxmox:update-nodes` to add their DNS records
1. `Ansible`: Add their name to the `hosts` list in the [RPI Inventory File](../ansible/inventories/rpi/main.yml) under the `rpi_local` group in format `rpiX.local`, where `X` is the incremental count number of total RPis (notice pre-existing RPis)


### Provisioning RPis
1. Each RPi will come online as `rpiX.local` (you'll be able to ping them with under this hostname)
1. Run `task rpi:list-rpis-local` to see them listed off Ansible inventory to ensure they've been added to the code base
1. Run `task rpi:pre-provision-rpis` to do initial hostname changes (i.e., give them proper hostnames in the domain)
1. Run `task rpi:provision-rpis` to do proper provisioning (i.e., install full Ubuntu changes, Unbound, AdGuard, etc.) ––
   **NOTE**: need to run `pre-provision-rpis` task before `provision-rpis` one, else RPis won't be provioned correctly
