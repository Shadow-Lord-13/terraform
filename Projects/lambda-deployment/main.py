import boto3
import logging

# Set up logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event):
    try:
        
        logger.info("Lambda function triggered with event: %s", event)

        # Example: List S3 buckets
        s3 = boto3.client('s3')

        bucket_name = event['Records'][0]['s3']['bucket']['name']
        logger.info("Listing objects in bucket: %s", bucket_name)
        response = s3.list_objects_v2(Bucket=bucket_name)

        if ['Content'] in response:
            logger.info("Objects in bucket:")
            for obj in response:
                logger.info("Object: %s, Size: %d bytes", obj['Key'], obj['Size'])

    except Exception as e:
        logger.error("Error while list the objects in the bukcet: %s", e)
