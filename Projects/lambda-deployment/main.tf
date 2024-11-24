provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_s3_logging_policy"
  description = "Policy for Lambda to access S3 and write logs"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect   = "Allow",
        Action   = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = [
          "arn:aws:s3:::file-processing-bucket*", # Replace with specific bucket ARN if required
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_role_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_lambda_function" "lambda" {
  function_name = "my_lambda_function"
  runtime       = "python3.12" # Specify your Python runtime
  role          = aws_iam_role.lambda_role.arn
  handler       = "main.lambda_handler"

  filename      = "${path.module}/main.zip" # Zipped Lambda function file

  environment {
    variables = {
      LOG_LEVEL = "INFO"
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_role_attach
  ]
}

resource "aws_s3_bucket" "file_processing_bucket" {
  bucket = "file-processing-bucket-1234567890"
  provider = aws.us_east_1
}

# resource "null_resource" "zip_lambda_code" {
#   provisioner "local-exec" {
#     command = "zip -j main.zip main.py"
#     working_dir = path.module
#   }

#   triggers = {
#     main_file = sha1(file("${path.module}/main.py"))
#   }

#   depends_on = []
# }


output "lambda_arn" {
  value = aws_lambda_function.lambda.arn
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
}