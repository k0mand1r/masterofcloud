require "rubycfn"
require "active_support/concern"
require_relative "../spec_helper"
require_relative "../../lib/main.rb"

module VpcSpec
  extend ActiveSupport::Concern
  include Rubycfn

  included do
    description "Infra Stack RSpec"
    include Concerns::GlobalVariables
    include Concerns::SharedMethods
    include VpcStack::InfraVpc
  end
end

VpcSpecCfn = include VpcSpec

describe VpcSpec do
  RspecVpcSpec = VpcSpecCfn.render_template
  let(:template) { JSON.parse(RspecVpcSpec) }

  context "Renders template" do
    subject { template }
    it { should have_key "Resources" }

    context "Has Required Resources" do
      let(:resources) { template["Resources"] }
      subject { resources }

      it { should have_key "InfraVpc" }
      it { should have_key "InfraRoute" }
      it { should have_key "InfraRouteTable" }
      it { should have_key "InfraVpcGatewayAttachment" }
      it { should have_key "InfraEc2PrivateSubnet" }
      it { should have_key "InfraEc2PrivateSubnet2" }
      it { should have_key "InfraEc2PrivateSubnet3" }
      it { should have_key "InfraInternetGateway" }
      it { should have_key "InfraNatGatewayRoute" }

      context "VPC has correct properties" do
        let(:properties) { resources["InfraVpc"]["Properties"] }
        subject { properties }

        it { should have_key "CidrBlock" }
        it { should have_key "EnableDnsHostnames" }
        it { should have_key "EnableDnsSupport" }
        it { should have_key "Tags" }

        context "VPC has expected CIDR block" do
          let(:cidr_block) { properties["CidrBlock"] }
          subject { cidr_block }

          it { should eq "192.168.0.0/16" }
        end 

        context "VPC supports DNS hostnames" do
          let(:dns_hostnames) { properties["EnableDnsHostnames"] }
          subject { dns_hostnames }

          it { should eq true }
        end

        context "VPC supports DNS" do
          let(:dns_support) { properties["EnableDnsSupport"] }
          subject { dns_support }

          it { should eq true }
        end

        context "VPC has mandatory tags" do
          # Create an array of the key names of the Tags specified
          # The `map` method iterates over the Tags array.
          # The hash array contains Hashes (aka Lists). The curly
          # brackets are the equivalent of a do |tag| .. end block.
          # Each iteration over the "Tags" array returns tag["Key"]
          # Finally, all of the tag["Key"]'s are returned as an array.
          let(:tags) { properties["Tags"].map { |tag| tag["Key"] } }
          subject { tags }

          # If you want to debug an rspec unit test, you can use the
          # $stderr.puts method. Uncomment the three lines below if you
          # want to see the contents of the `tags` variable.

          # it "uncomment if you want to see the tags contents" do
          #   $stderr.puts tags.inspect
          # end

          # Finally, we test if the tags atleast include Environment and Name.
          it "correct tags are set" do
            expect(tags).to include(*%w(Environment Name))
          end
        end
      end
    end
  end
end
