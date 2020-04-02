from __future__ import print_function

import json
import os
import urllib3

def lambda_handler(event, context):
    HOOK_URL=os.getenv('SLACK_POSTHOOK_URL')
    DOMAIN_NAME=os.getenv('MY_DOMAIN_NAME')
    slack_message = {
        "channel": "masterofcloud",
        "text": ":fiesta_parrot: " + DOMAIN_NAME + " completed the assignment :fiesta_parrot:",
        "icon_emoji": ":rocket:"
    }
    http = urllib3.PoolManager()
    encoded_data = json.dumps(slack_message).encode('utf-8')
    response = http.request("POST", HOOK_URL, body=encoded_data, headers={'Content-Type': 'application/json'})
    print(str(response.status) + str(response.data))
    return { 
        'statusCode': 200,
        'body': "Everything went amazing!"
    }    
