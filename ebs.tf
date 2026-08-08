# Root block device settings for the EC2 instance.
locals {
  root_block_device = {
    volume_type           = var.root_block_device.volume_type
    volume_size           = var.root_block_device.volume_size
    iops                  = var.root_block_device.iops
    throughput            = var.root_block_device.throughput
    encrypted             = var.root_block_device.encrypted
    kms_key_id            = var.root_block_device.kms_key_id
    delete_on_termination = var.root_block_device.delete_on_termination
    tags                  = merge(var.tags, { Name = var.name })
  }
}
