output "consul_sever" {
  value = aws_instance.consul_server.*.public_ip
}

output "consul_agent" {
  value = aws_instance.consul_webserver.*.public_ip
}

