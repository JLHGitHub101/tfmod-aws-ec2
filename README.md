# tfmod-aws-ec2

Terraform module for deploying a simple AWS EC2 instance with sensible, security-focused defaults.

## Features

- **IMDSv2 enforced by default** – instance metadata service is configured to require session-oriented requests, protecting against SSRF attacks.
- **Encrypted root volume by default** – root EBS volume encryption is enabled out of the box.
- **Optional additional EBS volumes** – attach and configure extra EBS block devices as needed.
- **Flexible networking** – control subnet placement, security groups, and public IP association independently.
- **SSH key pair support** – optionally associate an EC2 key pair for SSH access.
- **IAM instance profile support** – attach an IAM role to the instance for AWS API access.
- **User data support** – pass raw or base64-encoded user data scripts for instance initialisation.
- **Detailed monitoring toggle** – enable CloudWatch detailed monitoring with a single variable.
- **Consistent tagging** – all resources (instance, root volume) inherit the same tag map with an auto-applied `Name` tag.

## Usage

```hcl
module "ec2" {
  source = "github.com/JLHGitHub101/tfmod-aws-ec2"

  name          = "my-instance"
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.small"
  subnet_id     = "subnet-0123456789abcdef0"

  vpc_security_group_ids = ["sg-0123456789abcdef0"]
  key_name               = "my-key-pair"

  associate_public_ip_address = false

  root_block_device = {
    volume_size = 30
    encrypted   = true
  }

  tags = {
    Environment = "production"
    Project     = "my-project"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| aws | >= 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | Name to assign to the EC2 instance and related resources. | `string` | — | yes |
| `ami` | AMI ID to use for the EC2 instance. | `string` | — | yes |
| `instance_type` | EC2 instance type. | `string` | `"t3.micro"` | no |
| `subnet_id` | ID of the subnet in which to launch the instance. | `string` | — | yes |
| `vpc_security_group_ids` | List of security group IDs to associate with the instance. | `list(string)` | `[]` | no |
| `key_name` | Name of the EC2 key pair to associate with the instance. | `string` | `null` | no |
| `iam_instance_profile` | Name or ARN of an IAM instance profile to associate with the instance. | `string` | `null` | no |
| `associate_public_ip_address` | Whether to associate a public IP address with the instance. | `bool` | `false` | no |
| `user_data` | User data script to provide when launching the instance. | `string` | `null` | no |
| `user_data_base64` | Base64-encoded user data. Conflicts with `user_data`. | `string` | `null` | no |
| `root_block_device` | Configuration for the root block device (type, size, encryption, etc.). | `object` | `{}` | no |
| `ebs_block_devices` | Additional EBS block devices to attach to the instance. | `list(object)` | `[]` | no |
| `monitoring` | Whether to enable detailed CloudWatch monitoring. | `bool` | `false` | no |
| `metadata_options` | IMDSv2 metadata service configuration. | `object` | `{}` | no |
| `tags` | Map of tags to assign to the instance and its volumes. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | ID of the EC2 instance. |
| `arn` | ARN of the EC2 instance. |
| `public_ip` | Public IP address of the EC2 instance, if applicable. |
| `private_ip` | Private IP address of the EC2 instance. |
| `public_dns` | Public DNS name of the EC2 instance, if applicable. |
| `private_dns` | Private DNS name of the EC2 instance. |
| `availability_zone` | Availability Zone in which the instance was launched. |
| `subnet_id` | ID of the subnet in which the instance is running. |
| `vpc_id` | ID of the VPC in which the instance is running. |
| `instance_state` | State of the EC2 instance. |

## License

MIT