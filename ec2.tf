resource "aws_instance" "web_vm" {
  ami                         = data.aws_ami.linux_Server_pr.id
  instance_type               = "t2.micro"
  key_name                    = "demo-key"
  subnet_id                   = data.aws_subnet.selected.id
  security_groups             = [data.aws_security_group.selected.id]
  associate_public_ip_address = true

  tags = {
    Name = "Web-Server"
  }
}