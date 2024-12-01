import boto3
import logging

# Set up logging
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

def lambda_handler(event,context):
    try:
        
        logger.info("Lambda function triggered with event: %s", event)

        # Example: List S3 buckets
        s3 = boto3.client('s3')

        bucket_name = event['Records'][0]['s3']['bucket']['name']
        logger.info("Listing objects in bucket: %s", bucket_name)
        response = s3.list_objects_v2(Bucket=bucket_name)

        if 'Contents' in response:
            for obj in response['Contents']:
                logger.info("Object: %s, Size: %d bytes", obj['Key'], obj['Size'])
        else:
            logger.info("No objects found in the bucket.")

        return {
        "statusCode": 200,
        "body": "Lambda executed successfully!"
    }
    except Exception as e:
        logger.error("Error while list the objects in the bucket: %s", e)
