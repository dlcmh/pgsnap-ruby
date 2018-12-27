# frozen_string_literal: true

module Examples
  module Queries
    class CarBrandsAsJsonObject < Pgsnap::Query
      def select_list
        select_list_item 'cb.name', :name
      end

      def table_expression
        from :car_brands, :cb
        limit 1
      end

      def result
        json_object_result
      end
    end
  end
end
