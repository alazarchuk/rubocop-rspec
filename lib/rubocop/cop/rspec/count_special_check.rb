# frozen_string_literal: true

module RuboCop
  module Cop
    module RSpec
      class CountSpecialCheck < Cop
        MSG = 'In this example please use .count method for testing state that appeared as a result of some actions,not after some actions.'.freeze

        def_node_search :contains_count_method?, <<-PATTERN
          (send _ :count)
        PATTERN

        def_node_search :contains_assigns?, <<-PATTERN
          (send _ :assigns ...)
        PATTERN

        def_node_search :count, <<-PATTERN
          (send
            (send nil? :expect
              (send $(...) :count)) :to
            (send nil? :eq
              (int _)))
        PATTERN

        def on_block(node)
          return unless example?(node)
          return unless contains_count_method?(node)

          all_count = to_enum(:find_all_count, node).to_a

          if all_count.count.odd? || no_matching_count?(all_count)
            add_offense(node)
          end
        end

        def find_all_count(node, &block)
          count(node) do |count_receiver|
            next if contains_assigns?(count_receiver)
            yield :count=> count_receiver
          end
        end

        def no_matching_count?(counts)
          count_calls_per_receiver =
            counts
              .group_by { |elem| elem[:count] }
              .values
              .map! { |value| value.count }

          count_calls_per_receiver.any? { |el| el.odd? }
        end
      end
    end
  end
end
