resource "aws_transfer_server" "transfer_server" {
  identity_provider_type = "SERVICE_MANAGED"
  logging_role           = aws_iam_role.transfer_server_role.arn

  tags = {
    Name      = var.transfer_server_name
    CreatedBy = "Terraform"
  }
}

resource "aws_transfer_user" "transfer_server_user" {
  count          = length(var.transfer_server_user_names)
  server_id      = aws_transfer_server.transfer_server.id
  user_name      = var.transfer_server_user_names[count.index]
  role           = aws_iam_role.transfer_server_role.arn
  home_directory = "/${var.bucket_name}"
}

resource "aws_transfer_ssh_key" "transfer_server_ssh_key" {
  count     = length(var.transfer_server_user_names)
  server_id = aws_transfer_server.transfer_server.id
  user_name = aws_transfer_user.transfer_server_user[count.index].user_name
  body      = var.transfer_server_ssh_keys[count.index]
}
