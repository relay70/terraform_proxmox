terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}


resource "proxmox_vm_qemu" "newVM" {
  vmid         = 0
  target_node  = "pve"
  name         = var.hostname
  clone        = "fedora39Temp"
  full_clone   = true
  #boot         = "order=scsi0"
  boot         = "c"
  
  scsihw       = "virtio-scsi-pci"
  os_type      = "cloud-init"
  agent        = 0
  ciupgrade    = false
  ciuser       = var.ciUser
  cipassword   = var.ciPassword

  memory = 2048
  cores  = 2
  ipconfig0    = "ip=${var.ipaddress},gw=${var.gateway}"
  #ipconfig0    = "ip=${var.ipaddress},gw=${var.gateway},ip6=fe80::192:168:1:14/64,gw6=fe80::192:168:1:14"

  nameserver   = "192.168.1.12,192.168.1.1"


  skip_ipv6    = true
  #pxe          = false

  #password = var.proxmox_pass
  #nameserver = "$var.nameservers"
  #nameserver = "192.168.1.12"

  disks {
    scsi {
      scsi0 {
        disk {
          size = "50G"
          storage = "VMDisks_Containers"
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "VMDisks_Containers"
        }
      }
    }
  }

  #rootfs {
  #storage = "VMDisks_Containers"
  #size    = "50G"
  #}
  network {
    #name   = "eth0"
    model  = "virtio"
    bridge = "vmbr0"
  #   #ip     = "192.168.1.4/24"
  #  ip = var.ipaddress
    #gw     = "192.168.1.1"
  #  gw = var.gateway
  }


}
