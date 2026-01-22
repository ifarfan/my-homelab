# Tailscale

Run **tailscale** in a `container` as a **subnet route**

See https://tailscale.com/kb/1282/docker
Examples: https://github.com/tailscale-dev/docker-guide-code-examples


## LXC configuration

### 1. Generate Auth key
1. Go to https://login.tailscale.com/admin/settings/keys
1. Click on `Generate Auth key...`
1. Type new name under `Description`, ensure `Reusable` is checked and expiration is max (90 days)
1. Click `Generate key` and store key in as safe place (i.e. Doppler)

### 2. Approve to use as a subnet-router
1. Go to https://login.tailscale.com/admin/machines
1. Find new host on list, click on `...` on the right and then `Edit route settings`
1. Check box for IP CIDR range and then `Save`
1. Profit!


# LXC Permissions Issue
Update `LXC` to launch **Tailscale** w/ enough privileges, see::
  - https://github.com/portainer/portainer/issues/8478
  - https://forum.proxmox.com/threads/how-to-enable-tun-tap-in-a-lxc-container.25339/#post-126984
  - https://pve.proxmox.com/wiki/OpenVPN_in_LXC

This is now handled via the [proxmox-lxc-patch.yml](/docs/proxmox-lxc-patch.yml) playbook
