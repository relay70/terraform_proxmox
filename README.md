# terraform_proxmox

### Description
A terraform script that will created a number of ProxMox VMs or LXCs.
It will prompt for whether you want and VM, or LXC and execute accordingly.  Skipping the modules that it does not need to run.
There are three integrations with different Terraform providers:
- ProxMox provider to create the VMs and LXCs
- HashiCorp Vault for pulling secrets
- phpIPAM for pulling the next avaialable IPs.

### Usage
Execute: terraform apply -var=hosts='["host1", "host2"]'
This will created to VMs or LXCs called host1, and host2. At least one hostname is required. 
