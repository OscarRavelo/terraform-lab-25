provider "aws" {
region = "eu-west-1"
}


resource "aws_s3_bucket" "terraform_bucket" {
bucket = "terraform-bucket-oscar-lab-25"

force_destroy = false

}


resource "aws_s3_bucket_versioning" "historial" {
bucket = aws_s3_bucket.terraform_bucket.id

versioning_configuration {
status = "Enabled"
}

}


# Mini-Ejercicio 2: La tabla de bloqueo
resource "aws_dynamodb_table" "candado_terraform" {
  name         = "terraform-locks-oscar-lab25" # Puedes cambiar este nombre si quieres
  billing_mode = "PAY_PER_REQUEST"             # Para que sea gratis si no la usas
  hash_key     = "LockID"                      # <--- OBLIGATORIO: Terraform busca esto

  attribute {
    name = "LockID"                            # <--- OBLIGATORIO: Tiene que coincidir con arriba
    type = "S"                                 # S = String (Texto)
  }
}


terraform {
backend "s3" {

bucket = "terraform-bucket-oscar-lab-25"

key = "global/s3/terraform.tfstate"

region = "eu-west-1"

dynamodb_table = "terraform-locks-oscar-lab25"

encrypt = true

}
}
