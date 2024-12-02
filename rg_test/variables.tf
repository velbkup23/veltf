variable "environment" {
  type    = string
  default = "dev"
}

variable "region" {
  type = string
  default = "eastus"
}

variable "stactnameprefix" {
  type = string
  default = "velcist"
}

variable "actkind" {
  type = string
  default = "FileStorage"
}

variable "acttier" {
  type = string
  default = "Standard"
}

variable "actreptype" {
  type = string
  default = "LRS"
}