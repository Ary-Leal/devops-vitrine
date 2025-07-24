provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "devops_api" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 22.04 LTS (verifique se está atual)
  instance_type = "t2.micro"

  tags = {
    Name = "DevOpsAPI"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y docker.io
              sudo systemctl start docker
              sudo docker run -d -p 80:3000 ghcr.io/seuusuario/devops-api
              EOF
}
