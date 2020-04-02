require "rubycfn"
require "active_support/concern"
require_relative "../spec_helper"
require_relative "../../lib/main.rb"

module LambdaSpec
  extend ActiveSupport::Concern
  include Rubycfn

  included do
    description "Infra Stack RSpec"
    include Concerns::GlobalVariables
    include Concerns::SharedMethods
    include LambdaStack::LambdaFunction
  end
end

LambdaSpecCfn = include LambdaSpec

# We only enable this for assignment 4
if ENV["ASSIGNMENT_FOUR"] == "true"
  describe LambdaSpec do
    RspecLambdaSpec = LambdaSpecCfn.render_template
    let(:template) { JSON.parse(RspecLambdaSpec) }

    context "Renders template" do
      subject { template }
      it { should have_key "Resources" }

      context "Serverless Transformations are enabled" do
        let(:transform) { template["Transform"] }
        subject { transform }

        it { should eq "AWS::Serverless-2016-10-31" }
      end

      context "Has Required Resources" do
        let(:resources) { template["Resources"] }
        subject { resources }

        it { should have_key "MyServerlessFunction" }

        context "Serverless Function has correct properties" do
          let(:properties) { resources["MyServerlessFunction"]["Properties"] }
          subject { properties }

          it { should have_key "Description" }
          it { should have_key "Environment" }
          it { should have_key "Events" }
          it { should have_key "Handler" }
          it { should have_key "InlineCode" }
          it { should have_key "Timeout" }
          it { should have_key "Runtime" }
          it { should_not have_key "CodeUri" }
          it { should_not have_key "AssumeRolePolicyDocument" }
          it { should_not have_key "AutoPublishAlias" }
          it { should_not have_key "AutoPublishCodeSha256" }
          it { should_not have_key "DeploymentPreference" }
          it { should_not have_key "DeadLetterQueue" }
          it { should_not have_key "EventInvokeConfig" }
          it { should_not have_key "FunctionName" }
          it { should_not have_key "KmsKeyArn" }
          it { should_not have_key "Layers" }
          it { should_not have_key "PermissionsBoundary" }
          it { should_not have_key "Policies" }
          it { should_not have_key "ReservedConcurrentExecutions" }
          it { should_not have_key "Role" }
          it { should_not have_key "Tracing" }
          it { should_not have_key "VersionDescription" }
          it { should_not have_key "VpcConfig" }

          context "Serverless Function has correct Environment variables" do
            let(:env_vars) { properties["Environment"]["Variables"].keys }
            subject { env_vars }

            it "mandatory env var set" do
              expect(env_vars).to include(*%w(MY_DOMAIN_NAME SLACK_POSTHOOK_URL))
            end
          end

          context "Serverless Function has permitted runtime" do
            let(:runtime) { properties["Runtime"] }
            subject { runtime }

            it "Correct runtime has been set" do
              expect(%w(python3.7 python3.8)).to include(*[runtime])
            end
          end

          context "API Gateway has slackposter configuration" do
            let(:events) { properties["Events"] }
            subject { events }

            it { should have_key "slackposter" }

            context "slackposter has a Type and Properties" do
              let(:slackposter) { events["slackposter"] }
              subject { slackposter }

              it { should have_key "Type" }
              it { should have_key "Properties" }

              context "slackposter Properties have a Path and a Method" do
                let(:slackposter_properties) { slackposter["Properties"] }
                subject { slackposter_properties }

                it { should have_key "Path" }
                it { should have_key "Method" }

                context "slackposter Method is configured for POST requests" do
                  let(:method) { slackposter_properties["Method"] }
                  subject { method }

                  it { should eq "post" }
                end
              end
            end
          end
        end
      end
    end
  end
end
