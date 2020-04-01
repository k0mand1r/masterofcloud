module TwoStack
  module StoreConfiguration
    extend ActiveSupport::Concern
    included do
      parameter :website_url,
                description: "URL of the S3 Bucket"

      parameter :bucket_name,
                description: "Name of the bucket"

      parameter :bucket_domain_name,
                description: "Domain name of the bucket"

      # https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-parameter.html
      resource :website_url_parameter_store,
               type: "AWS::SSM::Parameter" do |r|
        r.property(:name) { "#{environment}websiteurl" }
        r.property(:type) { "String" }
        r.property(:value) { "YOU FIGURE THIS OUT" }
        r.property(:description) { "URL of S3 Bucket Website" }
      end

      resource :bucket_domain_parameter_store,
               type: "AWS::SSM::Parameter" do |r|
        r.property(:name) { "#{environment}bucketdomain" }
        r.property(:type) { "String" }
        r.property(:value) { "YOU FIGURE THIS OUT" }
        r.property(:description) { "Domain of S3 Bucket" }
      end

      resource :bucket_name_parameter_store,
               type: "AWS::SSM::Parameter" do |r|
        r.property(:name) { "#{environment}bucketname" }
        r.property(:type) { "String" }
        r.property(:value) { "YOU FIGURE THIS OUT" }
        r.property(:description) { "Name of the website bucket" }
      end
    end
  end
end
