#===============================
# Declarar proveedor de nube
#===============================
provider "aws" {
    region = "us-east-1"
    profile = "aws_pcaceres"
}

#========================================
# Recursos declaraciones de componentes
#========================================
# Crear VPC Dafault
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# Crear  servidor EC2
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Frontend
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "frontend"
  }
}

# Backend
resource "aws_instance" "backend" {
    ami = "ami-0aa7d40eeae50c9a9"
    instance_type = "t2.micro"

    tags = {
      Name = "backend"
    }
  
}

# Base de datos
resource "aws_instance" "db" {
  ami           = "ami-00874d747dde814fa"
  instance_type = "t2.micro"

  tags = {
    Name = "db"
  }
}


#  Consulta de datos (opcional)

#============================
# Ciclo de vida Terraform
#============================

# Inicializar: terraform init

# Verificar diseño: terraform plan

# Aplicar el diseño: terraform apply

# Destruir infraestructura: terraform destroy


