# Terraform
Use Terraform for `IaC` with **Proxmox**

## Installation
Install **Terraform** and auxiliary tools via `mise` (versions managed in `mise.toml`)
```shell
mise install
```

## Usage
- **Terraform** is invoked via `task` and all plans are stored under `terraform` folder
- Notice use of `var-file` (to use secrets) and `-backend-config` for state-file


## Notes
- Password variables are stored under `secrets.auto.tfvars` and are invoked automatically
- See `secrets.auto.tfvars.sample` as a reference file
- Run `./fetch-secrets.sh` to populate secrets + credentials
- **NOTE**: ensure secrets file is never checked into **git** :warning:


## Troubleshooting
- To enable `Terraform` debugging:
  `export TF_LOG=TRACE`
- To disable `Terraform` debugging:
  ` export TF_LOG=ERROR`
- Error messages will show under `terraform/logs/NODE_X.log`
