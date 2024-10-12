ansible all -m ping -u root --ask-pass
ansible-playbook test.yml -u root --ask-pass


ansible-galaxy role install ajsalminen.hosts

# Homelab
> Requirements: 

## Proxmox
Install proxmox following oficial documentation:

https://www.proxmox.com/en/proxmox-virtual-environment/get-started

### Proxmox VM Template
Necessary to configure vm template to run terraform against proxmox. Follow the doc:

https://pve.proxmox.com/wiki/Cloud-Init_Support

### Terraform

Please create a user in proxmox to auth terraform, by using following commands:
```
pveum role add TerraformProv -privs "Datastore.AllocateSpace Datastore.AllocateTemplate Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt"

pveum user add terraform-prov@pve --password YOURPASSWORD

pveum aclmod / -user terraform-prov@pve -role TerraformProv
```
After that create terraform.tfvars:

```shell
pm_user     = "terraform-prov@pve"
pm_password = "terraform"
```

and then, to spin up all the machines in proxmox use:

```shell
terraform apply
```
### Ansible

## Portainer

## Kubernetes

## Workstation

Run

```
ansible-playbook workstation/local.yml
```
After, restart computer.
