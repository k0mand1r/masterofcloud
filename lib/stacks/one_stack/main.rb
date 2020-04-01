module OneStack
  extend ActiveSupport::Concern
  include Rubycfn

  included do
    include Concerns::GlobalVariables
    include Concerns::SharedMethods
    include OneStack::Bucket

    description generate_stack_description("OneStack")
  end
end
