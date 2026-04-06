# Ansible

Install Galaxy collections
```shell
ansible-galaxy collection install -r ansible/requirements.yml

# initial install
ansible-galaxy collection install community.proxmox
ansible-galaxy collection install community.docker
# or upgrade
ansible-galaxy collection install --upgrade community.proxmox
ansible-galaxy collection install --upgrade community.docker
```
