# frozen_string_literal: true

module Examples
  module Queries
    class CarCatalog < Pgsnap::Query
      def table_expression
        from :car_brands, :cb
        inner_join :car_models, :cm, on: 'cb.id = cm.car_brand_id'
      end

      def select_list
        column 'cb.name', :brand
        column 'cm.year', :year
        column 'cm.name', :name
      end

      def order_by_clause
        sort :brand
        sort :year, :desc
      end

      def result
        json_result
      end
    end
  end
end
