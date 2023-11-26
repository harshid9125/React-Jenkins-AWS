output "vpc_id" {
  value       = aws_vpc.main.id
  description = "vpc id."
}

output "aws_subnet" {
  value = aws_vpc.main.id
}

output "public_subnet_az1_id" {
  value = aws_subnet.public_subnet_az1.id
}

output "public_subnet_az2_id" {
  value = aws_subnet.public_subnet_az2.id
}

output "private_data_subnet_az1_id" {
  value = aws_subnet.private_data_subnet_az2.id
}

output "private_data_subnet_az2_id" {
  value = aws_subnet.private_data_subnet_az2.id
}

output "alb_security_group_id" {
  value = aws_security_group.alb_security_group.id
}