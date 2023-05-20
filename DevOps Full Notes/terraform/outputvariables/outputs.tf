output "jumpbox_publicip" {
    value = aws_instance.fithealth2jumpbox.public_ip
    description = "jumpbox public ip address"
}
output "rds_db_endpoint" {
  value = aws_db_instance.fithealth2rdsinstance.endpoint
  description = "rds endpoint"
}