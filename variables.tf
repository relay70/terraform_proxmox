variable "hosts" {
  description = "Host names"
  type        = list(string)
}

variable "machineType" {
  description = "VM or LXC"

  validation {
    condition     = var.machineType == "VM" || var.machineType == "LXC"
    error_message = "Need a machine type: VM or LXC"
  }

}
