resource "proxmox_vm_qemu" "master" {
  name        = "master-node"
  desc        = "tf description"
  target_node = "procyon"
  //template ubuntu 22.04
  clone = "VM 9001"
  disks {
    ide {
      ide3 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = 4

        }
      }
    }
  }
  scsihw  = "virtio-scsi-single"
  cores   = 3
  sockets = 1
  cpu     = "kvm64"
  memory  = 2560
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
  ssh_user = "root"
  ciuser = "luiz"
  os_type = "cloud-init"
  //ipconfig0 = "ip=dhcp"
  ipconfig0 = "ip=192.168.1.99/24,gw=192.168.1.1"
  sshkeys = file("${path.module}/id_rsa.pub")
}


resource "proxmox_vm_qemu" "node_1" {
  name        = "node-1"
  desc        = "tf description"
  target_node = "procyon"
  //template ubuntu 22.04
  clone = "template-ubuntu-22.04"
  disks {
    ide {
      ide3 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = 4
        }
      }
    }
  }
  scsihw  = "virtio-scsi-single"
  cores   = 1
  sockets = 1
  cpu     = "kvm64"
  memory  = 2560
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
  ssh_user = "root"
  ciuser = "luiz"
  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.1.100/24,gw=192.168.1.1"
sshkeys = file("${path.module}/id_rsa.pub")
}