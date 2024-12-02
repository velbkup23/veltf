locals {
  filtered_list = [for dep, employees in var.departments : employees if !(contains(var.excluded_departments, dep))]
}