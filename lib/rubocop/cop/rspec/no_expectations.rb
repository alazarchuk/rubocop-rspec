# frozen_string_literal: true

module RuboCop
  module Cop
    module RSpec
      class NoExpectations < Cop
        MSG = 'Example has no expectations.'.freeze

        def_node_matcher :running_example?, Examples::EXAMPLES.block_pattern
        def_node_matcher :expect?, (Expectations::ALL).send_pattern
        def_node_search :contains_expect?, (Expectations::ALL).send_pattern
        def_node_search :contains_should?, <<-PATTERN
          (send _ {:should :should_not :should_receive :should_not_receive} ...)
        PATTERN

        def on_block(node)
          return unless ( running_example?(node) && (!contains_expect?(node) && !contains_should?(node) ) )

          add_offense(node)
        end
      end
    end
  end
end
