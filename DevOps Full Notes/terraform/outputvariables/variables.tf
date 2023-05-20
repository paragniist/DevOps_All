variable "fithealth2_vpc_cidr" {
    type = string
}
variable "fithealth2_prvsn1_cidr" {
  type = string
}
variable "fithealth2_prvsn2_cidr" {
  type = string
}
variable "fithealth2_pubsn3_cidr" {
  type = string
}
variable "sql_port"{
    type = number
}
variable "ssh_port" {
    type = number
}
variable "public_key" {
    type = string
}
variable "jumpboxconfig" {
    type = object({
        instance_type = string
        ami = string
        associate_public_ip_address = bool
        tags = map(string)
    })
}
variable "db_name" {
    type = string
}
variable "rds_engine" {
    type = string
}
variable "rds_engine_version" {
    type = string
}
variable "rds_instance_class" {
    type = string
}
variable "rds_root_username" {
    type = string
}
variable "rds_password"{ 
    type = string
}













