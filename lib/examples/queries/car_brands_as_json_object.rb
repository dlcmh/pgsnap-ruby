# frozen_string_literal: true

require_relative 'query_index'

module Examples
  module Queries
    class CarBrandsAsJsonObject < Pgsnap::Query
      def select_list
        select_list_item 'cb.*'
      end

      def table_expression
        from Examples::Queries::QueryIndex.car_brands, :cb
        limit 1
      end

      def result
        json_object_result
      end
    end
  end
end
