variable "tomcat_vpc_cidr" {
  type = string
}
variable "tomcat_vpc_name" {
  type = string
}
variable "tomcat_pub_subnet_cidr" {
  type = string
}
variable "tomcat_pub_subnet_name" {
  type = string
}
variable "tomcat_az" {
  type = string
}
variable "tomcat_route_cidr" {
  type = string
}
variable "tomcat_ig_name" {
  type = string
}
variable "tomcat_security_group_name" {
  type = string
}
variable "tomcat_ingress" {
  type = object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  })
}
variable "tomcat_key_name" {
  type = string
}
variable "tomcat_public_key" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "ami" {
  type = string
}
variable "associate_public_ip_address" {
  type = bool
}
variable "instance_name" {
  type = string
}
