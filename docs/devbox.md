# DevBox

After the `DevBox` LXC has been provisioned, run the following commands from within to complete configuration:

```shell
# Github CLI –– will prompt for browser authentication
gh auth login

# Doppler CLI –– will prompt for browser authentication
doppler login

# Fetch repo secrets + credentials + SSH keys
cd ~/repos/my-homelab
./fetch-secrets.sh
./fetch-devbox-keys.sh
```
