module TwoStack
  extend ActiveSupport::Concern
  include Rubycfn

  included do
    include Concerns::GlobalVariables
    include Concerns::SharedMethods
    include TwoStack::StoreConfiguration

    description generate_stack_description("TwoStack")
  end
end
