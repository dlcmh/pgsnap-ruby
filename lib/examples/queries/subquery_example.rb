# frozen_string_literal: true

module Examples
  module Queries
    class SubqueryExample < Pgsnap::Query
      def select_list
        select_list_item 'sq1.year', :year
      end

      def table_expression
        from car_model_sq, :sq1
      end

      private

      def car_model_sq
        Examples::Queries::CarModel.new.as_subquery
      end
    end
  end
end
