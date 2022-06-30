## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional tags for appending to tags\_as\_list\_of\_maps. | `map(string)` | `{}` | no |
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | Additional tags to append to standard mandatory tags | `map(string)` | `{}` | no |
| <a name="input_application"></a> [application](#input\_application) | The application to which the resource relates | `string` | n/a | yes |
| <a name="input_attribute"></a> [attribute](#input\_attribute) | An attribute of the resource that makes it unique | `string` | n/a | yes |
| <a name="input_costcode"></a> [costcode](#input\_costcode) | Name of the costcode | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment into which resource is deployed. e.g. 'prod', 'staging', 'dev', 'UAT' | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to assign to Resource. It could be an organization name or abbreviation, e.g. 'cpp' or 'hmcts' | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Name of the project or sqaud within the PDU which manages the resource. May be a persons name or email also | `string` | n/a | yes |
| <a name="input_persistence"></a> [persistence](#input\_persistence) | The operating hours for an ec2 server. Either in start:stop format or a True/False which indicates 24/7. False terminates resource automatically, Ignore means the resource will be manually managed. | `string` | `"False"` | no |
| <a name="input_role"></a> [role](#input\_role) | The role of the object in he environment. Required for VM's. eg. web\_server, message broker, app\_server | `string` | `""` | no |
| <a name="input_spot_enabled"></a> [spot\_enabled](#input\_spot\_enabled) | Is the VM resource a spot instance or not? true or false | `string` | `""` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of the of the resource. E.g rg, vm, subnet | `string` | n/a | yes |
| <a name="input_version_number"></a> [version\_number](#input\_version\_number) | The version of the application or object being deployed. This could be a build object or other artefact which is appended by a CI/Cd platform as part of a process of standing up an environment | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_asg_tags"></a> [asg\_tags](#output\_asg\_tags) | Additional tags as a list of maps, which can be used for tagging ASG resources |
| <a name="output_id"></a> [id](#output\_id) | Resource ID. A name that may be used for the resource |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags as a list of key/value pairs |
