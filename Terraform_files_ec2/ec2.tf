data "aws_ami" "amzn2_latest" {
most_recent      = true
 owners           = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel*"]
  }
  
}

data "aws_ami" "ubuntu_latest" {
most_recent      = true
 owners = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
  }
  
}

resource "aws_instance" "Ansible_Master" {
    ami= data.aws_ami.amazn2_latest.id
    instance_type= var.instance_type
    associate_public_ip_address = true
    
    subnet_id = aws_subnet.public_1.id
    key_name = "mumbai"
    vpc_security_group_ids = [aws_security_group.mysg.id]

    root_block_device {
      volume_size = 8
      volume_type = "gp2"
    }
 connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./mumbai.pem")
    host     = self.public_ip
  }

provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install ansible2",
      "sudo pip install ansible",

    ]

  }
  

  tags = {
    Name = "Ansible_master"
  }  

 
  
}

resource "aws_instance" "Ansible_slave" {
    ami= data.aws_ami.ubuntu_latest.id
    instance_type= var.instance_type
    associate_public_ip_address = true
    
    subnet_id = aws_subnet.public_1.id
    key_name = "mumbai"
    vpc_security_group_ids = [aws_security_group.mysg.id]

    root_block_device {
      volume_size = 8
      volume_type = "gp2"
    }

  }
  

  tags = {
    Name = "Ansible_slave"
  }  

 