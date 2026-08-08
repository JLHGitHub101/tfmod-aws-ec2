variable "name" {
  description = "Name to assign to the EC2 instance and related resources."
  type        = string
}

variable "ami" {
  description = "AMI ID to use for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "ID of the subnet in which to launch the instance."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the instance."
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "Name of the EC2 key pair to associate with the instance."
  type        = string
  default     = null
}

variable "iam_instance_profile" {
  description = "Name or ARN of an IAM instance profile to associate with the instance."
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance."
  type        = bool
  default     = false
}

variable "user_data" {
  description = "User data script to provide when launching the instance."
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "Base64-encoded user data to provide when launching the instance. Conflicts with `user_data`."
  type        = string
  default     = null
}

variable "root_block_device" {
  description = "Configuration for the root block device."
  type = object({
    volume_type           = optional(string, "gp3")
    volume_size           = optional(number, 20)
    iops                  = optional(number, null)
    throughput            = optional(number, null)
    encrypted             = optional(bool, true)
    kms_key_id            = optional(string, null)
    delete_on_termination = optional(bool, true)
  })
  default = {}
}

variable "ebs_block_devices" {
  description = "Additional standalone EBS volumes to attach to the instance."
  type = list(object({
    device_name = string
    volume_type = optional(string, "gp3")
    volume_size = optional(number, 20)
    iops        = optional(number, null)
    throughput  = optional(number, null)
    encrypted   = optional(bool, true)
    kms_key_id  = optional(string, null)
  }))
  default = []
}

variable "monitoring" {
  description = "Whether to enable detailed monitoring for the instance."
  type        = bool
  default     = false
}

variable "metadata_options" {
  description = "Configuration for instance metadata (IMDSv2)."
  type = object({
    http_endpoint               = optional(string, "enabled")
    http_tokens                 = optional(string, "required")
    http_put_response_hop_limit = optional(number, 1)
    instance_metadata_tags      = optional(string, "disabled")
  })
  default = {}
}

variable "tags" {
  description = "Map of tags to assign to the instance and its volumes."
  type        = map(string)
  default     = {}
}
