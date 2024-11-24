import boto3
import logging

# Set up logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    try:
        
        logger.info("Lambda function triggered with event: %s", event)

        # Example: List S3 buckets
        s3 = boto3.client('s3')

        bucket_name = event['Records'][0]['s3']['bucket']['name']
        response = s3.list_objects_v2(Bucket=bucket_name)

        if ['Content'] in response:
            print("Objects in bucket:")
            for obj in response:
                print(f" - {obj['key']} (Size: {obj['Size']} bytes)")


        return {
            "statusCode": 200,
            "body": "Lambda executed successfully!"
        }
    except Exception as e:
        print(f"Error: {e}")
