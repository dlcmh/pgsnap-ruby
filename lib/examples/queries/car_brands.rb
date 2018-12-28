# frozen_string_literal: true

module Examples
  module Queries
    class CarBrands < Pgsnap::Query
      def table_expression
        from :car_brands, :cb
      end

      def select_list
        select_list_item 'cb.name', :name
      end

      def order_by_clause
        sort 1, :desc
        sort 'cb.id'
      end
    end
  end
end
