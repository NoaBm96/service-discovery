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
}