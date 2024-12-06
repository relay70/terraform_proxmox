terraform {
  required_providers {
    phpipam = {
      source  = "lord-kyron/phpipam"
      version = "1.6.2"
    }
  }
}




##Variablize these
data "phpipam_subnet" "subnet" {
  subnet_address = var.netAddress
  subnet_mask    = var.maskBits
}

data "phpipam_first_free_address" "next_address" {
  subnet_id = data.phpipam_subnet.subnet.subnet_id
}


#resource "phpipam_address" "new_ip" {
#  subnet_id = data.phpipam_subnet.subnet.subnet_id
#  ip_address = data.phpipam_first_free_address.next_address.ip_address
#  hostname = var.hostname
#  description = "TF configured"
#  depends_on = []
#}

resource "phpipam_first_free_address" "new_ip" {
  subnet_id = data.phpipam_subnet.subnet.subnet_id
  hostname = var.hostname
} 



