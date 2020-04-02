module LambdaStack
  module LambdaFunction
    extend ActiveSupport::Concern
    included do
      # https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-resource-function.html
      transform # This keyword enables CloudFormation transformations. In essence, it allows for the use of Serverless Framework (SAM) in CFN.

      lambda_function_code = file_to_inline("lib/lambdas/post_to_slack.py") # Useful method for storing code as a single String

      # ASSIGNMENT: Implement this as a Serverless Resource
    end
  end
end
