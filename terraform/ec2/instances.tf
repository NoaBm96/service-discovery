resource "aws_instance" "consul_server" {
  ami                     = data.aws_ami.ubuntu.id
  count                   = var.consul_server
  instance_type           = var.instance_type
  key_name                = var.key_name
  iam_instance_profile    = aws_iam_instance_profile.consul_join.name
  vpc_security_group_ids  = [aws_security_group.consul_sg.id]
  user_data               = file("../scripts/consul-server.sh")
  subnet_id               = module.vpc_module.public_subnets_id[0]
  tags = {
    Name = "Consul-host-${count.index + 1}"
    consul_server = "true"
  }
  # connection {
  #   type                = "ssh"
  #   host                = "${self.private_ip}"
  #   user                = "ubuntu"
  #   private_key         = file(var.private_key_path)
  #   bastion_host        =  aws_instance.bastion_host.public_ip
  #   bastion_user        = "ubuntu"
  #   bastion_private_key = file(var.private_key_path)
  # }
  # provisioner "file" {
  #   source      = "../scripts"
  #   destination = "/home/ubuntu"  
  # }
  #  provisioner "remote-exec" {
  #   inline = [
  #     "chmod u+x scripts/consul-agent.sh",
  #     "sudo bash ./scripts/consul-agent.sh"
  #   ]
  #  } 
}

resource "aws_instance" "consul_webserver" {
  ami                      = data.aws_ami.ubuntu.id
  count                    = var.consul_server_web
  instance_type            = var.instance_type
  key_name                 = var.key_name
  subnet_id                = module.vpc_module.public_subnets_id[0]
  iam_instance_profile     = aws_iam_instance_profile.consul_join.name
  vpc_security_group_ids   = [aws_security_group.consul_sg.id]
  user_data               = file("../scripts/consul-agent.sh")

  tags = {
    Name = "Consul-agent-${count.index + 1}"
  }
  # connection {   
  #     host                = aws_instance.consul_server.private_ip
  #     user                = "ubuntu"
  #     private_key         = file(var.private_key_path)     
  #     type                = "ssh"
  #     bastion_host        =  aws_instance.bastion_host.public_ip
  #     bastion_user        = "ubuntu"
  #     bastion_private_key = file(var.private_key_path) 
  #   } 

  # provisioner "file" {
  #   source      = "../scripts/consul-server.sh"
  #   destination = "/home/ubuntu/consul-server.sh"  
  # }
  #  provisioner "remote-exec" {
  #   inline = [
  #     "chmod u+x consul-server.sh",
  #     "sudo bash ./consul-server.sh"
  #   ]
  #  }
  # tags = {
  #   Name = "consul-server"
  #   consul_server = "true"
  # }
}
