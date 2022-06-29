output "tags" {
  value       = local.tags
  description = "Tags as a list of key/value pairs"
}

output "asg_tags" {
  value       = local.tags_as_list_of_maps
  description = "Additional tags as a list of maps, which can be used for tagging ASG resources"
}

output "id" {
  value       = local.id_case
  description = "Resource ID. A name that may be used for the resource"
}
