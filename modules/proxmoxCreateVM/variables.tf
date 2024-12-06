variable "hostname" {
  description = "HostName"
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

variable "ciUser" {
  description = "Cloud Init User"
  type = string
}

variable "ciPassword" {
  description = "Cloud Init User Password"
  type = string
}

