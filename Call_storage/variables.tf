variable "account_kind" {
  type = string
}

variable "account_tier" {
  type = string
}

variable "account_replication_type" {
  type    = string
  default = "LRS"
}

variable "appname" {
  type = string
}

variable "location" {
  type    = string
  default = "centralindia"
}

variable "storage_resources" {
  type = map(set(string))
  default = {
    "profile" = ["profile_share*3"]
    "office"  = ["office_share*2"]
  }
}