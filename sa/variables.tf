variable "rg_name" {
  default       = "rg_terraform_edrm"
  description   = "resource group"
  type = string
}
variable "resource_group_location" {
  default = "southcentralus"
  description   = "Location of the resource group."
  type = string
}
variable "sa_name" {
  default       = "saterraformedrm"
  description   = "name of the storage account"
  type = string
}
variable "account_tier" {
  default       = "Standard"
  description   = "account tier selected ."
  type = string
}
variable "account_replication_type" {
  default       = "LRS"
  description   = "Replication tier selected"
  type = string
}
variable "createdBy" {
  default       = "EDRM"
  description   = "Initials of the person who create the resource"
  type = string
}