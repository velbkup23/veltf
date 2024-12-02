locals {
  /* storage_resources = {
    profile = ["profile_share*2"]
    office = ["office_share*2"]
  } */

  flattened_storage_resources = flatten([
    for key, resources in var.storage_resources : [
      for resource in resources : [
        for sequence in range(try(split("*", resource)[1], 1)) : {
          resource_type = key
          resource_name = split("*", resource)[0]
          resource_seq  = sequence + 1
        }
      ]
    ]
  ])
}