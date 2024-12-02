variable "resource_group_name" {
  type = string
}

variable "appname" {
  type = string
}

variable "location" {
  type = string
}

variable "account_tier" {
  type = string
}

variable "account_replication_type" {
  type = string
}

variable "account_kind" {
  type = string
}

variable "public_network_access_enabled" {
  type    = string
  default = true
}