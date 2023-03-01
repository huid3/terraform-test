# terraform-test

## Module Docs

GKE: https://github.com/terraform-google-modules/terraform-google-kubernetes-engine

VPC/subnets: https://github.com/terraform-google-modules/terraform-google-network

## Terraform State File Configuration

Terraform state is stored in a GCS bucket. The bucket is setup is done here: https://github.com/huid3/terraform-test-state-bucket

Use the [backend-config flag](https://developer.hashicorp.com/terraform/language/settings/backends/configuration#partial-configuration) to pass in the credentials since vairables cannot be used in the backend block to setup connection to GCS bucket.

```
terraform init -backend-config="<PATH_TO_SERVICE_ACCOUNT_CREDENTIALS>"
terraform plan
terraform apply
```
