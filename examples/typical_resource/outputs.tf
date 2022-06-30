output "tag_set1_tags" {
  value       = module.tag_set1.tags
  description = "terratest"
}

output "resource1_id" {
  value       = module.tag_set1.id
  description = "terratest"
}

output "tag_set2_tags" {
  value       = module.tag_set2.tags
  description = "terratest"
}

output "resource2_id" {
  value       = module.tag_set2.id
  description = "terratest"
}
