variable "namelist" {
  type    = list(string)
  default = ["one", "two", "three"]
}

variable "words" {
  type    = list(string)
  default = ["hello", "world", "terraform"]
}

variable "envs" {
  type    = list(string)
  default = ["prod", "dev", "staging"]
}

variable "strings" {
  type    = list(string)
  default = ["apple", "cat", "banana", "dog", "grape"]
}

variable "key_value_tuples" {
  type = list(tuple([string, number]))
  default = [
    ["apple", 5],
    ["banana", 3],
    ["cherry", 6]
  ]
}

variable "users" {
  default = [
    ["Alice", "Developer", "New York"],
    ["Bob", "Manager", "San Francisco"],
    ["Charlie", "Tester", "London"]
  ]
}

variable "resources" {
  default = [
    { name = "bucket1", type = "s3", region = "us-east-1" },
    { name = "bucket2", type = "s3", region = "us-west-2" },
    { name = "instance1", type = "ec2", region = "eu-central-1" },
    { name = "instance2", type = "ec2", region = "us-west-2" }
  ]
}

variable "network_data" {
  default = [
    { name = "subnet-1", region = "us-east-1", public = true },
    { name = "subnet-2", region = "us-east-1", public = false },
    { name = "subnet-3", region = "us-west-2", public = true },
    { name = "subnet-4", region = "us-west-2", public = false }
  ]
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnets" {
  default = [
    { name = "subnet-a", size = 4 },
    { name = "subnet-b", size = 6 },
    { name = "subnet-c", size = 8 }
  ]
}

variable "environments" {
  default = ["dev", "staging", "prod"]
}

variable "default_tags" {
  default = {
    team = "engineering"
  }
}

variable "custom_tags" {
  default = {
    staging = { team = "qa" }
    prod    = { critical = "true" }
  }
}


output "env_tags" {
  value = {
    for env in var.environments : env => (env == "staging" || env == "prod" ? merge(var.default_tags, lookup(var.custom_tags, env, {})) : var.default_tags)
  }
}

variable "departments" {
  default = {
    engineering = ["Alice", "Bob", "Charlie"]
    hr          = ["Diana", "Edward"]
    sales       = ["Frank", "Grace"]
  }
}

variable "excluded_departments" {
  default = ["hr"]
}



variable "server_config" {
  default = {
    "web"   = { count = 3, region = "us-east-1" }
    "db"    = { count = 2, region = "us-west-2" }
    "cache" = { count = 1, region = "eu-central-1" }
  }
}

variable "project_config" {
  default = {
    "frontend" = {
      "env"     = "prod"
      "version" = "1.2"
      "team"    = "UI"
    }
    "backend" = {
      "env"     = "staging"
      "version" = "2.0"
      "team"    = "API"
    }
    "analytics" = {
      "env"     = "dev"
      "version" = "0.9"
      "team"    = "Data"
    }
  }
}

variable "exclude_env" {
  default = ["dev", "staging"]
}

variable "def_tags" {
  default = {
    "environment" = "dev"
    "project"     = "website"
  }
}

variable "team_specific_tags" {
  default = {
    "UI" = {
      "owner"   = "Alice"
      "contact" = "ui-team@example.com"
    }
    "API" = {
      "owner"   = "Bob"
      "contact" = "api-team@example.com"
    }
  }
}

variable "teams" {
  default = ["UI", "API"]
}

output "team_tags" {
  value = flatten([
    for team in var.teams :
    merge(lookup(var.team_specific_tags, team, {}), var.def_tags)  
    ]
  )
}

