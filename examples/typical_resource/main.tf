module "tag_set1" {
  source         = "../../"
  costcode       = "devops"
  owner          = "terratest"
  namespace      = "cpp"
  version_number = "v0.0.1"
  application    = "platform"
  type           = "linux"
  attribute      = "bastion1"
  environment    = "dev"
  role           = "webapp"
}

module "tag_set2" {
  source         = "../../"
  costcode       = "devops"
  owner          = "terratest"
  namespace      = "cpp"
  version_number = "v0.0.1"
  application    = "platform"
  type           = "blobstorage"
  attribute      = "splunklogging"
  environment    = "dev"
  role           = "sensitive_datastore"
}
