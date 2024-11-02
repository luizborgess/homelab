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


Create Vm Template with the following script:

Script:
```
apt update -y
apt install libguestfs-tools -y
rm focal-server-cloudimg-amd64.img
wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
sudo virt-customize -a focal-server-cloudimg-amd64.img --install qemu-guest-agent
sudo qm create 9001 --name "ubuntu-2004-cloudinit-template" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
qm importdisk 9001 focal-server-cloudimg-amd64.img local-lvm
qm set 9001 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9001-disk-0
qm set 9001 --boot c --bootdisk scsi0
qm set 9001 --ide2 local-lvm:cloudinit
qm set 9001 --serial0 socket --vga serial0
qm set 9001 --agent enabled=1
```
Configure ssh with:
```
ssh-keygen -t rsa
```

Make sure **id_rsa.pub** is located in terraform folder, and in **~/.ssh** directory.


Login into servers with the command:
```
ssh user@192.168.1.99
```

## Terraform

Please create a user in proxmox to auth terraform, by using following commands:
```shell
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
## Ansible

In ansible folder, configure the **inventory.yml** with the machine ips and then run this command to install k3s cluster:

```
ansible-playbook playbooks/site.yml -i inventory.yml
```


## Portainer

## Kubernetes

## Workstation

Run

```
ansible-playbook workstation/local.yml
```
After, restart computer.
