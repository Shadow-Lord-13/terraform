# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address = "http://<>:8200" # replace <> with the ublic ip of the instance which is hosting the vault
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "<>" #replace <> with role_id
      secret_id = "<>" #replace <> with secret_id
    }
  }
}

data "vault_kv_secret_v2" "read_kv" {
  mount = "kv"
  name = "bucket-name"
}

# resource "aws_instance" "terra_instance_1" {
#   ami                     = "ami-0e86e20dae9224db8"
#   instance_type           = "t2.micro"
#   key_name                = "ubun-pri-key"
#   tags = {
#     Name = "terra-instance-1"
#   }
# }

resource "aws_s3_bucket" "terra_vault_bucket" {
  bucket = data.vault_kv_secret_v2.read_kv.data["name"]
}