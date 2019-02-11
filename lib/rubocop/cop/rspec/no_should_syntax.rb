# frozen_string_literal: true

module RuboCop
  module Cop
    module RSpec
      class NoShouldSyntax < Cop
        MSG = 'In this test example please correct old should syntax to new expect syntax.'.freeze

        def_node_matcher :running_example?, Examples::EXAMPLES.block_pattern
        def_node_search :contains_should?, <<-PATTERN
          (send _ {:should :should_not :should_receive :should_not_receive} ...)
        PATTERN

        def on_block(node)
          return unless running_example?(node) && contains_should?(node)

          add_offense(node)
        end
      end
    end
  end
end
