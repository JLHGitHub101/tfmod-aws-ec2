output "id" {
  description = "ID of the EC2 instance."
  value       = aws_instance.this.id
}

output "arn" {
  description = "ARN of the EC2 instance."
  value       = aws_instance.this.arn
}

output "public_ip" {
  description = "Public IP address of the EC2 instance, if applicable."
  value       = aws_instance.this.public_ip
}

output "private_ip" {
  description = "Private IP address of the EC2 instance."
  value       = aws_instance.this.private_ip
}

output "public_dns" {
  description = "Public DNS name of the EC2 instance, if applicable."
  value       = aws_instance.this.public_dns
}

output "private_dns" {
  description = "Private DNS name of the EC2 instance."
  value       = aws_instance.this.private_dns
}

output "availability_zone" {
  description = "Availability Zone in which the instance was launched."
  value       = aws_instance.this.availability_zone
}

output "subnet_id" {
  description = "ID of the subnet in which the instance is running."
  value       = aws_instance.this.subnet_id
}

output "vpc_id" {
  description = "ID of the VPC in which the instance is running."
  value       = data.aws_subnet.this.vpc_id
}

output "instance_state" {
  description = "State of the EC2 instance."
  value       = aws_instance.this.instance_state
}

output "ebs_volume_ids" {
  description = "Map of device name to EBS volume ID for each additional volume."
  value       = { for k, v in aws_ebs_volume.this : k => v.id }
}
