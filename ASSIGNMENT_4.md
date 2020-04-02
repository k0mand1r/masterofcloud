# Infrastructure for Master of Cloud - Excercise 4

```
   _____                   __                         _____  _________ .__                   .___
  /     \ _____    _______/  |_  ___________    _____/ ____\ \_   ___ \|  |   ____  __ __  __| _/
 /  \ /  \\__  \  /  ___/\   __\/ __ \_  __ \  /  _ \   __\  /    \  \/|  |  /  _ \|  |  \/ __ | 
/    Y    \/ __ \_\___ \  |  | \  ___/|  | \/ (  <_> )  |    \     \___|  |_(  <_> )  |  / /_/ | 
\____|__  (____  /____  > |__|  \___  >__|     \____/|__|     \______  /____/\____/|____/\____ | 
        \/     \/     \/            \/                               \/                       \/ 
```

## Introduction

The spec/lib/ folder of this project contains unit tests. Ideally, you write unit tests before you
write code. This way you can dictate a desired state, and verify whether your written code achieves
that objective.

This assignment is all about unit testing. The unit tests have already been written for you.
In this case, we're going to be implementing a Serverless (Lambda) function backed by API Gateway,
that will post a message to Slack when you perform a POST request to the API endpoint.

You will need to set the following variable in your .env.private:

`ASSIGNMENT_FOUR="true"`

During the assignment, you will need to configure a Slack Webhook. It is the webhook URL that is the
topic of the #masterofcloud Slack channel. Set it in .env.private as well.

`lib/lambdas/post_to_slack.py` contains the Lambda code that will de deployed. You won't need to
touch it. Instead, you'll work exclusively in `lib/stacks/lambda_stack/lambda_function.rb`. The only tools
you have are the unit tests and the AWS documentation to make this work. The './rake_spec.sh' script
performs the unit tests. These tools will be your compass.

Good luck :D

## Assignment

- Open `lib/stacks/lambda_stack/lambda_function.rb`
- Implement this Serverless Function
- Deploy
- Find the API Gateway endpoint in API Gateway -> Dashboard
- POST to that endpoint (e.g. with `curl`)

## Deliverables

- Screenshot of your API Gateway
- Screenshot of your curl post command output
- API Gateway invoked your Lambda function, which has posted to Slack

