import boto3
import logging

# Set up logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    logger.info("Lambda function triggered with event: %s", event)

    # Example: List S3 buckets
    s3 = boto3.client('s3')
    buckets = s3.list_buckets()
    logger.info("S3 Buckets: %s", buckets['Buckets'])

    return {
        "statusCode": 200,
        "body": "Lambda executed successfully!"
    }
