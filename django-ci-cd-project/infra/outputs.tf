output "instance_ip" {
  value = aws_instance.django_server.public_ip
}
