output "ipINFO" {
  value = [
    for i in range(length(module.phpipam)) :
    {
      "HostName"   = var.hosts[i]
      "IP Address" = module.phpipam[i].newIP.ip_address
      "Gateway"    = module.phpipam[i].defaultGateway
    }
  ]

}


output "hostsNames" {
  value = var.hosts
}

