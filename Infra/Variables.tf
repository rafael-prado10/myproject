variable "subscription_id" {
	description = "The subscription to create the deployment with."
	default     = "eb67b4f3-177f-4d86-a43c-18b0cf5ac569"
}

variable "tenant_id" {
	description = "The ID of the Azure Active Directory Tenant."
	default     = "1698d564-11b6-4051-82d4-e12549e0f6f3"
}


# PROJECT NAME 
variable project {
  default     = "Terraform"
}

# RESOURCE GROUP
variable resource_group_name {
    default ="RG-Terraform"
}

# NAME VIRTUAL MACHINE
variable name_virtual_machine {
    default ="LX-PRD-APP-0001"
}

variable admin_username {
    default ="rdmp"
}

variable admin_password {
    default ="teste@123"
}

variable name_virtual_network {
    default ="LX-PRD-APP-0001-VNET"
}
variable name_subnet {
    default ="LX-PRD-APP-0001-SUBNET" 
}

variable "network_interface_ids" {
    default = "nic-1"      
}

variable name_pubic_ip {
    default ="public_ip"
}
  
# LOCAL DA APLICAÇÃO
variable "location"{
    default = "eastus"
}

#TAGs
variable "tags" {
  default = {
    Ambiente            = "Terraform"
  }
}