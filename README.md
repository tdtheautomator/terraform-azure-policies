# Azure Policies
This plan is used to build VMSS with Front End Load Balancer, Bastion Host and Virtual Machines.
This plan also creates 3 custom policies and associated custom and built-in policies to resoruce group.

Tier 1 - VMSS (Web Servers with Rolling Update)

## What Does this plan do ?
A total of 36 resources are created.

1. Creates a 1 Resource Group in westus2
2. Creates 1 Virtual Network
3. Creates 3 Subnets
   * bastion-subnet 
   * tier1-subnet
   * tier2-subnet
4. Creates 2 Network Security Group
5. Creates 4 Public IPs
    * Bastion
    * Load Balancer
6.  Creates 1 Virtual Machine Scale Set with 2 Instances
    * SKU : Windows Server 2019
    * Instance Size : Standard_B2s
    * Instance are enabled with custom extension to deploy IIS
    * Automating Rolling Update enabled for Instances
7.  Creates 2 Virtual Machines
8. Creates Bastion Host
9. Create Custom AZ Policy to Audit Resources Not Created in UKWEST
10. Associated BuiltIn Policies and Custom Policy to Resource Group
   * Audit VMs without Managed Disk (Built-In)
   * Audit VMs with additional Admin Accounts (Built-In)
   * Audit VMs and VMSS with encruption disabled (Built-In)
   * Audit Resources outside of southeastasia region (Custom)
   * Audit RDP Access from Internet (Custom)
   * Audit SSH Access from Internet (Custom)

authenticate using : 
```
az login
```

post authentication token is received :

```
terraform init
terraform plan
terraform apply
```
*resources are created in westus for demonstration on AZ Policies, it takes upto 30 mins for compliance status to be reflected
*connection to bastion from internet is allowed by default*
*connection from bastion to all subnets in VNet is allowed by default*
*NSGs should be appropriately configured*
*there might be dependency issues faced while destroying, re-triggering destroy will proceed*
*some policy defination are copied to show case custom policies can also be built using terraform*