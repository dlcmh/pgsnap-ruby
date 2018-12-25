# frozen_string_literal: true

module Examples
  module Queries
    class SubqueryExample < Pgsnap::Query
      def select_list
        select_list_item 'sq1.year', :year
      end

      def table_expression
        from car_model_subquery, :sq1
      end

      def car_model_subquery
        Examples::Queries::CarModel.new.as_subquery
      end
    end
  end
end
