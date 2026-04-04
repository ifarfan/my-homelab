# Build Proxmox Templates via Packer

Build **Proxmox** VM templates with Packer

### Installation
Install **packer**:
```shell
brew install packer
packer version
```

Symlink secret values
```shell
cd packer
# Terraform secrets via magic/autoloading variables file
ln -s ../terraform/secrets.auto.tfvars secrets.auto.pkrvars.hcl

# Ansible secrets
cd ansible/playbooks
ln -s ../../../ansible/credentials.ini credentials.ini
```

### Usage
**build** script:
```shell
$> ./build.sh -h

Usage: build.sh --node <NODE> --template <TEMPLATE>

Parameters:
--node|-n <NODE>:
  Available node(s): m0 m1 m2

--template|-t <TEMPLATE>:
  Available templates(s): ubuntu-24-04
```


Build **Ubuntu 24.04** Proxmox template on `m1` node:
```shell
./build.sh -n m1 -t ubuntu-24-04
```
