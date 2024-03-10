resource "aws_instance" "web" {
  ami = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"
  count = 1
  user_data = "${file("install_httpd.sh")}"
  tags = {
	  Name = "HelloWorld"
	}
}

//Create Security Group
resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  
  tags = {
    Name = "allow_http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

