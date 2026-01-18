# Terraform
Use Terraform for `IaC` with **Proxmox**

## Installation
Install **Terraform** via `tfenv`
```shell
brew install tfenv
tfenv install 0.15.5
tfenv use 0.15.5
tfenv list
```

## Usage
For virtually all **Terraform** plans, from `terraform` root folder:

1. Create `template` folder + symlink appropriate secret values files
   ```shell
   mkdir new-template && cd new-template
   ln -s ../proxmox.auto.tfvars    proxmox.auto.tfvars
   ln -s ../cloudflare.auto.tfvars cloudflare.auto.tfvars
   ```
1. Proceed with `Terrafom` as usual
   ```shell
   tf init
   tf validate && tf fmt
   tf plan -compact-warnings
   tf apply -auto-approve
   ```

## Notes
- Password variables are stored under `terraform.tfvars` and are invoked automatically
- Use `terraform.tfvars.sample` as a reference file
- **NOTE**: ensure they are never checked into **git** :warning:


## Troubleshooting
- To enable `Terraform` debugging:
  `export TF_LOG=TRACE`
- To disable `Terraform` debugging:
  ` export TF_LOG=ERROR`
- Error messages will show under `terraform/logs/NODE_X.log`
