terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "4.5.0"
    }
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
    phpipam = {
      source  = "lord-kyron/phpipam"
      version = "1.6.2"
    }
  }
}

provider "vault" {
  #address         = var.vaultURL
  skip_tls_verify = true
}

data "vault_generic_secret" "phpIPAMInfo" {
  path = "kv/phpIPAM"
}

data "vault_generic_secret" "proxmoxInfo" {
  path = "kv/proxmox"
}
data "vault_generic_secret" "osInfo" {
  path = "kv/OS"
}

provider "proxmox" {
  pm_user     = data.vault_generic_secret.proxmoxInfo.data.tfUser
  pm_password = data.vault_generic_secret.proxmoxInfo.data.tfPassword
  pm_api_url  = data.vault_generic_secret.proxmoxInfo.data.URL
  pm_parallel = 1
  #pm_debug    = true
}


provider "phpipam" {
  # Configuration options
  app_id   = data.vault_generic_secret.phpIPAMInfo.data.tfAppID
  endpoint = data.vault_generic_secret.phpIPAMInfo.data.URL
  username = data.vault_generic_secret.phpIPAMInfo.data.tfUser
  password = data.vault_generic_secret.phpIPAMInfo.data.tfPassword
  insecure = true
}

module "phpipam" {
  source = "./modules/phpipam"
  #for_each   = toset(var.hosts)
  #hostname   = each.key
  count      = length(var.hosts)
  hostname   = var.hosts[count.index]
  netAddress = "192.168.1.0"
  maskBits   = "24"

}

locals {
  isVM  = var.machineType == "VM" ? length(var.hosts) : 0
  isLXC = var.machineType == "LXC" ? length(var.hosts) : 0
}

module "proxmoxCreateVM" {
  source = "./modules/proxmoxCreateVM"
  count    = local.isVM
  hostname = var.hosts[count.index]
  ipaddress = "${module.phpipam[count.index].newIP.ip_address}/24"
  ciUser = data.vault_generic_secret.osInfo.data.ciUser
  ciPassword = data.vault_generic_secret.osInfo.data.ciPassword

}

module "proxmoxCreateLXC" {
  source = "./modules/proxmoxCreateLXC"
  count        = local.isLXC
  hostname     = var.hosts[count.index]
  ipaddress    = "${module.phpipam[count.index].newIP.ip_address}/24"
  rootPassword = data.vault_generic_secret.osInfo.data.rootPassword
}
