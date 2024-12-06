terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}


resource "proxmox_lxc" "testlxc" {
  vmid         = 0
  target_node  = "pve"
  hostname     = var.hostname
  ostemplate   = "VMTemplates_ISOs:vztmpl/fedora-39-default_20231118_amd64.tar.xz"
  start        = true
  onboot       = true
  password     = var.rootPassword
  unprivileged = true

  #nameserver = "$var.nameservers"
  #nameserver = "192.168.1.12"

  memory = 1024
  cores  = 2
  rootfs {
    storage = "VMDisks_Containers"
    size    = "20G"
  }
  network {
    name   = "eth0"
    bridge = "vmbr0"
    #ip     = "192.168.1.4/24"
    ip = var.ipaddress
    #gw     = "192.168.1.1"
    gw = var.gateway
  }

  features {
    #  mount   = "nfs"
    nesting = "1"
  }

}
