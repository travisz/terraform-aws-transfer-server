# terraform-aws-transfer-server

Terraform module to create a aws transfer server (SFTP)

## Usage

```hcl
resource "aws_s3_bucket" "bucket" {
  bucket = "bucket_name"
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

module "sftp" {
  source = "git::https://github.com/travisz/terraform-aws-transfer-server?ref=master"

  transfer_server_name      = "sftp-server-name"
  transfer_server_user_names = [
    "transfer-user-01",
    "transfer-user-02"
  ]
  transfer_server_ssh_keys  = [
    "ssh-rsa AAAAB......",
    "ssh-rsa AAAAB......"
  ]
  bucket_name               = aws_s3_bucket.bucket.id
  bucket_arn                = aws_s3_bucket.bucket.arn
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| bucket_name | S3 bucket name | string | `` | yes |
| bucket_arn | S3 bucket ARN | string | `` | yes |
| transfer_server_name | Transfer Server name | string | `` | yes |
| transfer_server_user_names | Username(s) for SFTP server | list | `` | yes |
| transfer_server_ssh_keys | SSH Key(s) for transfer server user(s) | list | `` | yes |
