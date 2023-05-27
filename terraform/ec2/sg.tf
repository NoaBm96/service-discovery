  resource "aws_security_group" "consul_sg" {
  name        = "consul_sg"
  description = "Allow ssh & consul inbound traffic"
  vpc_id = module.vpc_module.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    self            = true
    description     = "Allow all inside security group"
  }

  ingress {
    description = "Allow consul traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { 
   	from_port       =  8500
    to_port         =  8500
    protocol        = "tcp" 
    #security_groups = [aws_security_group.consul-lb.id]
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow consul UI access from the world"
   }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    description     = "Allow all outside security group"
  }
}

# resource "aws_security_group" "consul-lb" { 
#  	name   = "consul-alb-security-group" 
#   vpc_id = module.vpc_module.vpc_id 
    
#   # Allow inbound HTTP requests
#   ingress { 
#     protocol    = "tcp" 
#     from_port   = 8500 
#     to_port     = 8500 
#     cidr_blocks = ["0.0.0.0/0"] 
#     } 
#     # Allow all outbound requests
#     egress { 
#      	from_port   = 0 
#       to_port     = 0 
#       protocol    = "-1" 
#       cidr_blocks = ["0.0.0.0/0"] 
#      } 
     
#      tags = { 
#      	Name = "consul-lb-sg" 
#       } 
#  } 
