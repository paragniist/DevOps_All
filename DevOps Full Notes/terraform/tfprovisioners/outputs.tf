output "javaserver_publicip" {
  value = aws_instance.javaserver.public_ip
  description = "java server public ip address"
}