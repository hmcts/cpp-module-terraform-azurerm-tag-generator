variable "costcode" {
  type        = string
  description = "Name of theDWP PRJ number (obtained from the project portfolio in TechNow)"
}

variable "owner" {
  type        = string
  description = "Name of the project or sqaud within the PDU which manages the resource. May be a persons name or email also"
}

variable "namespace" {
  type        = string
  description = "Namespace to assign to Resource. It could be an organization name or abbreviation, e.g. 'hmcts' or 'methods'"
}

variable "application" {
  type        = string
  description = "The application to which the resource relates"
}

variable "type" {
  type        = string
  description = "Type of the of the resource. E.g rg, vm, subnet"
}

variable "attribute" {
  type        = string
  description = "An attribute of the resource that makes it unique"
}

variable "environment" {
  type        = string
  description = "Environment into which resource is deployed. e.g. 'prod', 'staging', 'dev', 'UAT'"
}

variable "role" {
  type        = string
  description = "The role of the object in he environment. Required for VM's. eg. web_server, message broker, app_server"
  default     = ""
}

variable "version_number" {
  type        = string
  description = "The version of the application or object being deployed. This could be a build object or other artefact which is appended by a CI/Cd platform as part of a process of standing up an environment"
  default     = ""
}

variable "spot_enabled" {
  type        = string
  description = "Is the VM resource a spot instance or not? true or false"
  default     = ""
  validation {
    condition     = contains(["", "true", "false"], var.spot_enabled)
    error_message = "The spot_enabled value must be one of '', true, false."
  }
}

variable "persistence" {
  type        = string
  description = "The operating hours for an ec2 server. Either in start:stop format or a True/False which indicates 24/7. False terminates resource automatically, Ignore means the resource will be manually managed."
  default     = "False"
}

variable "additional_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to append to standard mandatory tags"
}

variable "additional_tag_map" {
  type        = map(string)
  default     = {}
  description = "Additional tags for appending to tags_as_list_of_maps."
}
