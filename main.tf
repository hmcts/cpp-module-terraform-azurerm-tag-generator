locals {
  defaults = {
    label_order         = ["namespace", "application", "environment", "attribute", "type"]
    regex_replace_chars = "/[^-a-zA-Z0-9]/"
    delimiter           = "-"
    replacement         = ""
    # Lambdas have a limit of 64 (the most restrictive of the resources)
    id_length_limit  = 50
    id_hash_length   = 5
    label_key_case   = "title"
    label_value_case = "lower"
    tag_key_case     = "title"
    tag_value_case   = ""
    tag_keys = {
      owner        = "owner"
      costcode     = "costcode"
      application  = "application"
      type         = "type"
      environment  = "environment"
      role         = "role"
      version      = "version"
      spot_enabled = "spot_enabled"
      persistence  = "persistence"
    }
  }

  id_context = {
    namespace   = var.namespace
    application = var.application
    environment = var.environment
    attribute   = var.attribute
    type        = var.type
  }

  label_order         = local.defaults.label_order
  label_value_case    = local.defaults.label_value_case
  regex_replace_chars = local.defaults.regex_replace_chars
  delimiter           = local.defaults.delimiter
  replacement         = local.defaults.replacement
  id_length_limit     = local.defaults.id_length_limit
  id_hash_length      = local.defaults.id_hash_length
  tag_key_case        = local.defaults.tag_key_case
  tag_value_case      = local.defaults.tag_value_case

  labels = [for l in local.label_order : local.id_context[l] if length(local.id_context[l]) > 0]

  # Generate a Unique Identifier (Name) for the resource (with the attribute it better be!)
  id_full = join(local.delimiter, local.labels)

  # Create a truncated ID if needed
  delimiter_length = length(local.delimiter)
  # Calculate length of normal part of ID, leaving room for delimiter and hash
  id_truncated_length_limit = local.id_length_limit - (local.id_hash_length + local.delimiter_length)
  # Truncate the ID and ensure a single (not double) trailing delimiter
  id_truncated = local.id_truncated_length_limit <= 0 ? "" : "${trimsuffix(substr(local.id_full, 0, local.id_truncated_length_limit), local.delimiter)}${local.delimiter}"
  # Support usages that disallow numeric characters.
  id_hash_plus = "${md5(local.id_full)}opqrstuvwx"
  id_hash_case = local.label_value_case == "title" ? title(local.id_hash_plus) : local.label_value_case == "upper" ? upper(local.id_hash_plus) : local.label_value_case == "lower" ? lower(local.id_hash_plus) : local.id_hash_plus
  id_hash      = replace(local.id_hash_case, local.regex_replace_chars, local.replacement)
  # Create the short ID by adding a hash to the end of the truncated ID
  id_short = substr("${local.id_truncated}${local.id_hash}", 0, local.id_length_limit)
  id       = local.id_length_limit != 0 && length(local.id_full) > local.id_length_limit ? local.id_short : local.id_full
  id_case  = local.label_value_case == "title" ? title(local.id) : local.label_value_case == "upper" ? upper(local.id) : local.label_value_case == "lower" ? lower(local.id) : local.id

  # Compose the Tags
  owner        = local.tag_value_case == "title" ? title(var.owner) : local.tag_value_case == "upper" ? upper(var.owner) : local.tag_value_case == "lower" ? lower(var.owner) : var.owner
  costcode     = local.tag_value_case == "title" ? title(var.costcode) : local.tag_value_case == "upper" ? upper(var.costcode) : local.tag_value_case == "lower" ? lower(var.costcode) : var.costcode
  version      = local.tag_value_case == "title" ? title(var.version_number) : local.tag_value_case == "upper" ? upper(var.version_number) : local.tag_value_case == "lower" ? lower(var.version_number) : var.version_number
  application  = local.tag_value_case == "title" ? title(var.application) : local.tag_value_case == "upper" ? upper(var.application) : local.tag_value_case == "lower" ? lower(var.application) : var.application
  type         = local.tag_value_case == "title" ? title(var.type) : local.tag_value_case == "upper" ? upper(var.type) : local.tag_value_case == "lower" ? lower(var.type) : var.type
  environment  = local.tag_value_case == "title" ? title(var.environment) : local.tag_value_case == "upper" ? upper(var.environment) : local.tag_value_case == "lower" ? lower(var.environment) : var.environment
  role         = local.tag_value_case == "title" ? title(var.role) : local.tag_value_case == "upper" ? upper(var.role) : local.tag_value_case == "lower" ? lower(var.role) : var.role
  spot_enabled = local.tag_value_case == "title" ? title(var.spot_enabled) : local.tag_value_case == "upper" ? upper(var.spot_enabled) : local.tag_value_case == "lower" ? lower(var.spot_enabled) : var.spot_enabled
  persistence  = local.tag_value_case == "title" ? title(var.persistence) : local.tag_value_case == "upper" ? upper(var.persistence) : local.tag_value_case == "lower" ? lower(var.persistence) : var.persistence

  tag_keys      = local.defaults.tag_keys
  tag_keys_case = local.tag_key_case == "title" ? { for akey, aval in local.tag_keys : akey => title(aval) } : local.tag_key_case == "upper" ? { for akey, aval in local.tag_keys : akey => upper(aval) } : local.tag_key_case == "lower" ? { for akey, aval in local.tag_keys : akey => lower(aval) } : local.tag_keys


  tag_ownr_nm      = local.tag_keys_case.owner
  tag_costcode_nm  = local.tag_keys_case.costcode
  tag_ver_nm       = local.tag_keys_case.version
  tag_app_nm       = local.tag_keys_case.application
  tag_typ_nm       = local.tag_keys_case.type
  tag_env_nm       = local.tag_keys_case.environment
  tag_rl_nm        = local.tag_keys_case.role
  tag_spt_enbld_nm = local.tag_keys_case.spot_enabled
  tag_prstnc_nm    = local.tag_keys_case.persistence

  mandatory_tags = {
    "Name"                   = local.id_case
    (local.tag_ownr_nm)      = local.owner
    (local.tag_costcode_nm)  = local.costcode
    (local.tag_ver_nm)       = local.version
    (local.tag_app_nm)       = local.application
    (local.tag_typ_nm)       = local.type
    (local.tag_env_nm)       = local.environment
    (local.tag_rl_nm)        = local.role
    (local.tag_spt_enbld_nm) = local.spot_enabled
    (local.tag_prstnc_nm)    = local.persistence
  }

  # don't meddle with the additional tags (pass them through as-is)
  tags = merge(local.mandatory_tags, var.additional_tags)

  tags_as_list_of_maps = flatten([
    for key in keys(local.tags) : merge(
      {
        key   = key
        value = local.tags[key]
    }, var.additional_tag_map)
  ])
}
