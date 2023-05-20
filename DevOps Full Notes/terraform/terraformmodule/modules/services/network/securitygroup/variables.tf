variable "vpc_id" {
  type = string
}
variable "ingress" {
  type = object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  })
}
variable "security_group_name" {
  type = string
}