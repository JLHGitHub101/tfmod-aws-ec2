resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.key_name
  iam_instance_profile   = var.iam_instance_profile

  associate_public_ip_address = var.associate_public_ip_address

  user_data        = var.user_data
  user_data_base64 = var.user_data_base64

  monitoring = var.monitoring

  root_block_device {
    volume_type           = local.root_block_device.volume_type
    volume_size           = local.root_block_device.volume_size
    iops                  = local.root_block_device.iops
    throughput            = local.root_block_device.throughput
    encrypted             = local.root_block_device.encrypted
    kms_key_id            = local.root_block_device.kms_key_id
    delete_on_termination = local.root_block_device.delete_on_termination

    tags = local.root_block_device.tags
  }

  metadata_options {
    http_endpoint               = var.metadata_options.http_endpoint
    http_tokens                 = var.metadata_options.http_tokens
    http_put_response_hop_limit = var.metadata_options.http_put_response_hop_limit
    instance_metadata_tags      = var.metadata_options.instance_metadata_tags
  }

  tags = merge(var.tags, { Name = var.name })

  lifecycle {
    ignore_changes = [ami]
  }
}
