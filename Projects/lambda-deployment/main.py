import boto3
import logging

# Set up logging
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

# Initialize the S3 client globally
s3 = boto3.client('s3')

def lambda_handler(event,context):
    try:
        
        logger.info("Lambda function triggered with event: %s", event)

        # Example: List S3 buckets
        
        #bucket_name = event['Records'][0]['s3']['bucket']['name']
        # Extract bucket name safely from the event
        bucket_name = event.get('Records', [{}])[0].get('s3', {}).get('bucket', {}).get('name')
        if not bucket_name:
            raise ValueError("Bucket name is missing in the event.")
        
        logger.info("Listing objects in bucket: %s", bucket_name)
        response = s3.list_objects_v2(Bucket=bucket_name)

        if 'Contents' in response:
            for obj in response['Contents']:
                logger.info("Object: %s, Size: %d bytes", obj['Key'], obj['Size'])
        else:
            logger.info("No objects found in the bucket.")

        return {
            "statusCode": 200,
            "body": "Lambda execution ended successfully!"
        }
    
    except Exception as e:
        logger.error("Error while listing objects in the bucket: %s", e)
