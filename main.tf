# Creating Ubuntu EC2 instance
resource "aws_instance" "ubuntu-vm-instance" {
  ami                    = var.ubuntu-ami
  instance_type          = var.ubuntu-instance-type
  associate_public_ip_address = true
  key_name               = aws_key_pair.deployer.key_name
  user_data     = file("./install_jenkins.sh")
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  tags = {
    Name = "jenkins-server"
    Environment = "production"
  }
}

# Creating key-pair on AWS using SSH-public key
resource "aws_key_pair" "deployer" {
  key_name   = var.key-name
  public_key = file("${path.module}/id_rsa.pub")
}

# Creating security group on AWS
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Security group for jenkins server"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}