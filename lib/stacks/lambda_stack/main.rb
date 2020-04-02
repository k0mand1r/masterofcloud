module LambdaStack
  extend ActiveSupport::Concern
  include Rubycfn

  included do
    include Concerns::GlobalVariables
    include Concerns::SharedMethods
    include LambdaStack::LambdaFunction

    description generate_stack_description("LambdaStack")
  end
end
