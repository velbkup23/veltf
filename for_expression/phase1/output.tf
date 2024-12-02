output "namelist_map" {
  value = { for item in var.namelist : item => length(item) }
}

output "words_upper" {
  value = [for word in var.words : upper(word)]
}

output "environments_servers" {
  value = [for env in var.envs : format("server_%s", env)]
}

output "atlstfive" {
  value = [for item in var.strings : item if length(item) >= 5]
}

output "list_tuple" {
  value = { for idx in var.key_value_tuples : idx[0] => idx[1] }
}

output "users_map" {
  value = { for idx in var.users : idx[0] => { role = idx[1], Location = idx[2] } }
}

output "resource_type" {
  value = { for resource in var.resources : resource.type => resource.name... }
}

output "network_data_regionwise" {
  value = { for nw in var.network_data : nw.region => {
    public  = [for nw in var.network_data : nw.name if nw.public],
    private = [for nw in var.network_data : nw.name if !nw.public]
    }...
  }
}

output "subnet_result" {
  value = { for subnet in var.subnets : subnet.name => cidrsubnet(var.vpc_cidr, subnet.size, 0) }
}

output "env_tags2" {
  value = {
    for env in var.environments : env => merge(
      var.default_tags,
      contains(["staging", "prod"], env) ? lookup(var.custom_tags, env, {}) : {}
    )
  }
}

output "emp_deptmnts2" {
  value = flatten(local.filtered_list)
}

output "emp_departments" {
  value = flatten([
    for dept, employees in var.departments :
    employees if !(contains(var.excluded_departments, dept))
  ])
}

output "sev_list" {
  value = flatten([
    for sevtype, params in var.server_config :
    [
      for server in range(params.count) :
      { "name"   = format("%s-%s", sevtype, server + 1)
        "region" = params.region
      }

    ]
  ])
}

output "project_list" {
  value = {
    for proj, deets in var.project_config :
    proj => deets.team if !(contains(var.exclude_env, deets.env))
  }
}

variable "regions" {
  default = ["us-east-1", "us-west-2", "eu-central-1"]
}

variable "instance_types" {
  default = ["t2.micro", "t3.medium", "m5.large"]
}


output "sku_matrix" {
  value = flatten([
    for region in var.regions : [
      for sku in var.instance_types :
      {
        region = region
        instance_type = sku
      }
    ]
  ]) 
}