from __future__ import print_function

import json
import os
import urllib3

def lambda_handler(event, context):
    HOOK_URL=os.getenv('SLACK_POSTHOOK_URL')
    slack_message = {
        "channel": "masterofcloud",
        "text": ":fiesta_parrot: Integration test. (Working on next assignment ;)) :fiesta_parrot:",
        "icon_emoji": ":rocket:"
    }
    http = urllib3.PoolManager()
    encoded_data = json.dumps(slack_message).encode('utf-8')
    response = http.request("POST", HOOK_URL, body=encoded_data, headers={'Content-Type': 'application/json'})
    print(str(response.status) + str(response.data))
