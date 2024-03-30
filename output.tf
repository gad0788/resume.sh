output "public_ip" {
  value = aws_instance.server.public_ip
}
output "ssh-command" {
  value = "ssh -i week7d2.pem ec2-user@${aws_instance.server.public_ip}"
}