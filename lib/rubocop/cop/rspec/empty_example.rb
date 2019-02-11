# frozen_string_literal: true

module RuboCop
  module Cop
    module RSpec
      #
      # Checks if an example includes code.
      #
      # @example usage
      #
      #   # bad
      #     it 'is chunky'
      #
      #   # good
      #
      #     it 'is chunky' do
      #       expect(bacon.chunky?).to be_truthy
      #     end
      #
      class EmptyExample < Cop
        MSG = 'Empty example detected.'.freeze

        def_node_matcher :empty_example?, <<-PATTERN
          (send nil? :it
            (str _))
        PATTERN

        def on_send(node)
          return if node.parent && node.parent.block_type?

          empty_example?(node) do
            add_offense(node)
          end
        end

        def on_block(node)
          return unless example?(node)
          return unless node.body.nil?

          add_offense(node)
        end
      end
    end
  end
end
