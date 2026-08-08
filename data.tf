data "aws_subnet" "this" {
  id = aws_instance.this.subnet_id
}
