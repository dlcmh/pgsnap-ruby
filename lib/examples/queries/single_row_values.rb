# frozen_string_literal: true

module Examples
  module Queries
    class SingleRowValues < Pgsnap::Query
      def select_list
        select_list_item 'dummy.*'
      end

      def table_expression
        from values(1, 2), :dummy
      end
    end
  end
end
