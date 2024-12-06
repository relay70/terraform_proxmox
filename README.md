# terraform_proxmox

### Description
A terraform script that will created a number of ProxMox VMs or LXCs.
It will prompt for whether you want and VM, or LXC and execute accordingly.  Skipping the modules that it does not need to run.
There are three integrations with different Terraform providers:
- ProxMox provider to create the VMs and LXCs
- HashiCorp Vault for pulling secrets
- phpIPAM for pulling the next avaialable IPs.
This code is part of a tutorial on Terraform conditionals (if/then).  The tutorial can be found here:
[https://www.relay70.com/2024/12/06/terraform-conditional-module-execution/](https://www.relay70.com/2024/12/06/terraform-conditional-module-execution/)

### Usage
Execute: 
terraform apply -var=hosts='["host1", "host2"]'

This will create two VMs or LXCs called host1, and host2. At least one hostname is required. 

### Requirements
Since this code uses specific key values from vault, it will require the same engines and key values to exist.  These are easily changed in the code though.
For the Vault provider to work you need the standard Vault environment variables to be set:
- VAULT_TOKEN
- VAULT_ADDR
- VAULT_NAMESPACE
