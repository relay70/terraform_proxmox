variable "hostname" {
  description = "HostName"
  type        = string
}
variable "rootPassword" {
  description = "rootPassword"
  type        = string
}

variable "ipaddress" {
  description = "ipAddress"
  type        = string
}

variable "gateway" {
  description = "Gateway"
  type        = string
  default     = "192.168.1.1"
}


