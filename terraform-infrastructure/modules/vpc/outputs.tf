output "vpc_id" {
  value = aws_vpc.project_vpc.id
}

output "igw_id" {
  value = aws_internet_gateway.project_igw.id
}