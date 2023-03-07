# terraform-test

## Documentation references

### Terraform modules

[GKE](https://github.com/terraform-google-modules/terraform-google-kubernetes-engine) 

[VPC/subnets](https://github.com/terraform-google-modules/terraform-google-network)

[Internal HTTP(s) Load Balancing setup](https://cloud.google.com/load-balancing/docs/l7-internal/setting-up-l7-internal)

### Github actions

[Terraform github action reference ](https://github.com/hashicorp/learn-terraform-github-actions/blob/main/.github/workflows/terraform.yml)

[setup-terraform action](https://github.com/hashicorp/setup-terraform)

## Terraform State File Configuration

Terraform state is stored in a GCS bucket. The bucket is setup is done here: https://github.com/huid3/terraform-test-state-bucket

Use the [backend-config flag](https://developer.hashicorp.com/terraform/language/settings/backends/configuration#partial-configuration) to pass in the credentials since variables cannot be used in the backend block to setup connection to GCS bucket.

```
terraform init -backend-config="<PATH_TO_SERVICE_ACCOUNT_CREDENTIALS>"
terraform plan
terraform apply
```

Setup local variable definitions in a `*.tfvars` file. e.g.
```
project_id = <GCP_PROJECT_ID>
```
## Secrets
GCP Terraform service account private key stored as github secret to use with google cloud auth github action.

## Troubleshooting
If github actions gets stuck on `terraform plan`, make sure all input variables are defined. `terraform plan` goes into an interactive mode when it cannot find all input variables.

If the remote state file is stuck in a lock state and you are certain no process is currently updating the state file. You can force unlock the state file with: `terraform force-unlock <LOCK-ID>`

If running into issues with the comment attached on PR - There's a limit to the number of characters inside a GitHub comment (65535).

## Next Steps
- use terragrunt to help keep files DRY when provisioning different environments (DEV, QA, PROD)
