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

describe LambdaSpec do
  RspecLambdaSpec = LambdaSpecCfn.render_template
  let(:template) { JSON.parse(RspecLambdaSpec) }

  context "Renders template" do
    subject { template }
    it { should have_key "Resources" }

    context "Has Required Resources" do
      let(:resources) { template["Resources"] }
      subject { resources }
    end
  end
end
