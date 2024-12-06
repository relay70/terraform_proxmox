output "newIP" {
    #value = data.phpipam_first_free_address.next_address.ip_address
    value = phpipam_first_free_address.new_ip
}

output "defaultGateway" {
    #value = data.phpipam_first_free_address.next_address.ip_address
    value = data.phpipam_subnet.subnet.gateway
}

output "nameServers" {
    #value = data.phpipam_first_free_address.next_address.ip_address
    value = data.phpipam_subnet.subnet.nameserver_id
}
