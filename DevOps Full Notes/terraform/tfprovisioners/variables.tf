variable "ec2config" {
    type = object({
        instanceType = string
        ami = string
        associatePublicIpAddress = bool
        publicKey = string
        tags = map(string)
    })
}
