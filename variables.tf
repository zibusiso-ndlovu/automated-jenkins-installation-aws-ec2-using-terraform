variable "aws_region" {
  description = "The AWS Region in which the resources will be provisioned."
  type        = string
  default     = "us-east-1"
}

variable "ubuntu-ami" {
  description = "Ubuntu AMI ID"
  type        = string
  default     = "ami-04b4f1a9cf54c11d0"
}

variable "ubuntu-instance-type" {
  description = "Ubuntu instance type"
  type        = string
  default     = "t2.micro"
}

variable "key-name" {
  description = "ubuntu key pair name"
  type        = string
  default     = "deployer-key"
}

variable "s3_bucket_name" {
  # description = "S3 Bucket name"
  type    = string
  default = "my-bucket-name"
}

variable "egress_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "ingress_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      description = "Allow all traffic through port 8080"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow SSH from my computer"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}


