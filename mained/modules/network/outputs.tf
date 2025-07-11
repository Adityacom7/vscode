output "vpc_id" {
  value = aws_vpc.main.id              # 📌 from internal resource
}

output "public_subnet_ids" {
  value = [aws_subnet.public_1.id, aws_subnet.public_2.id]  # 📌 from internal resources
}
