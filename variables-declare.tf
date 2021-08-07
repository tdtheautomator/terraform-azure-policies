#Declare Variables
variable "location" {}

variable "vnet_cidr" {}
variable "bastion_subnet_cidr" {}
variable "tier1_subnet_cidr" {}
variable "tier2_subnet_cidr" {}

variable "win_admin_name" {}
variable "win_admin_pass" {}
variable "win_compute_size" {}
variable "win_sku" {}

variable "lin_admin_name" {}
variable "lin_admin_pass" {}
variable "lin_compute_size" {}
variable "lin_offer" {}
variable "lin_sku" {}

variable "vmss-tier1-prefix" {}