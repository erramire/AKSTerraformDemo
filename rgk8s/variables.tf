variable "rg_name" {
  default       = "rg_ope_base_dev"
  description   = "resource group"
  type = string
}
variable "resource_group_location" {
  default = "southcentralus"
  description   = "Location of the resource group."
  type = string
}