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

