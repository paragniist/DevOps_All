tomcat_vpc_cidr = "10.0.0.0/16"
tomcat_vpc_name = "tomcat_vpc"
tomcat_pub_subnet_cidr = "10.0.1.0/24"
tomcat_pub_subnet_name = "tomcat_pub_subnet"
tomcat_az = "ap-south-1a"
tomcat_ig_name = "tomcat_ig"
tomcat_route_cidr = "0.0.0.0/0"
tomcat_security_group_name = "tomcat_sg"
tomcat_ingress = {
  cidr_blocks = ["0.0.0.0/0"]
  from_port = 22
  protocol = "TCP"
  to_port = 22
}
instance_name = "tomcatec2"
instance_type = "t2.micro"
ami = "ami-024c319d5d14b463e"
associate_public_ip_address = true
tomcat_key_name = "tomcatkp"
tomcat_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpHxMihFyyZ7Ih79udR42MhJzWxD/4+RPj09vSt152ruAHJmMCmBeAo1Jm/vCg7Os44SxRpFaj/gW0Fbo+BolxI4DYKrA6uIB8Uh7jJsmfvbbc4bE31qsEvu7RmeMbbJikxxnWdJR+pg0y54dUGnyOe/JKK2bhUN0rc925y4KjC0AhO35n61rQQAQ96Vsu6FRqoV07rA0lRk2XpV0kIilVaIqlo770/q3+Bm1n9Cpv2KFNQJ0/UNxNv19gUpnFTdo3cF8KKT4VB9lyA2kjue3COQvKUUifcvMjRBurFuWsD0Y/efngcHxpFZ+AbIymacuudBnyGVKgbAqDarwpQYSWySkBk9x1evPH/N+P9bYfDP13pMcBxtmfgV9bSZLoigTjqWM8P8ICXJdJ8RGIwmOLHT5zR5q+QeeLT+0SCpR1bXygY+K5TTeJmhJN0JUWVBi4TcnrbIzueNSdGFEM03/7nJelIG4I3g2QkYJ5GEXnEqg2znVUXBvzySxBA7NxmdM= Sriman@DESKTOP-1QI4S5N"
