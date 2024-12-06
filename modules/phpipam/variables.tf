###built Vault, and put these in there###
variable "netAddress" {
  description = "Subnet"
  type = string
}

variable "maskBits" {
  description = "Subnet Bits"
  type = string
}
variable "hostname" {
  description = "Host name"
  #default = ["kubeMaster", "kubeNode01", "kubeNode02"]
  type = string
}