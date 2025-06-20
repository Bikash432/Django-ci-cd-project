provider "aws" {
  region = "us-east-1"
}

# Create S3 bucket
resource "aws_s3_bucket" "django_static" {
  bucket = "django-static-assets-${random_id.bucket_id.hex}"
  acl    = "private"
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

# Create RDS PostgreSQL
resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "13.4"
  instance_class       = "db.t3.micro"
  name                 = "django_db"
  username             = "admin"
  password             = "YourSecurePass123"
  skip_final_snapshot  = true
  publicly_accessible  = true
}

# Create Launch Template
resource "aws_launch_template" "django_lt" {
  name_prefix   = "django-template"
  image_id      = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "my-key"

  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y python3-pip
              pip3 install django gunicorn psycopg2-binary
              # Add deployment steps or Git pull
              EOF
  )
}

# Auto Scaling Group
resource "aws_autoscaling_group" "django_asg" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = ["subnet-xxxxxxxx"] # Replace with your subnet ID
  launch_template {
    id      = aws_launch_template.django_lt.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "DjangoAutoScale"
    propagate_at_launch = true
  }
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "s3_bucket_name" {
  value = aws_s3_bucket.django_static.bucket
}
