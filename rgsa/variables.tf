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