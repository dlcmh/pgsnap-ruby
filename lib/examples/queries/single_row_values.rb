# frozen_string_literal: true

module Examples
  module Queries
    class SingleRowValues < Pgsnap::Query
      def select_list
        column 'dummy.*'
      end

      def table_expression
        from values('Something'), :dummy
        # from values(1), :dummy
        # from values(1, 'A random piece of text'), :dummy
      end
    end
  end
end
