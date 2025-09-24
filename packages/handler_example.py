# Minimal Lambda handler for packaging

def lambda_handler(event, context):
    print("Received event:", event)
    return {"statusCode": 200, "body": "ok"}
