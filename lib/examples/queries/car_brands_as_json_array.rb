# frozen_string_literal: true

module Examples
  module Queries
    class CarBrandsAsJsonArray < Pgsnap::Query
      def select_list
        select_list_item 'cb.name', :name
      end

      def table_expression
        from Examples::Queries::QueryIndex.car_brands, :cb
        limit 3
      end

      def result
        json_array_result
      end
    end
  end
end
