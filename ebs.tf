# Root block device settings — expressed as a nested block on aws_instance.
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

# Additional EBS volumes created with the modern aws_ebs_volume resource.
resource "aws_ebs_volume" "this" {
  for_each = { for d in var.ebs_block_devices : d.device_name => d }

  availability_zone = aws_instance.this.availability_zone

  type       = each.value.volume_type
  size       = each.value.volume_size
  iops       = each.value.iops
  throughput = each.value.throughput
  encrypted  = each.value.encrypted
  kms_key_id = each.value.kms_key_id

  tags = merge(var.tags, { Name = "${var.name}-${each.key}" })
}

resource "aws_volume_attachment" "this" {
  for_each = aws_ebs_volume.this

  device_name                    = each.key
  volume_id                      = each.value.id
  instance_id                    = aws_instance.this.id
  stop_instance_before_detaching = true
}

