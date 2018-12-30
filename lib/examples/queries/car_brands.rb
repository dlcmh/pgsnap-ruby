# frozen_string_literal: true

module Examples
  module Queries
    class CarBrands < Pgsnap::Query
      def table_expression
        from :car_brands, :cb
      end

      def select_list
        column 'cb.name', :name
      end

      # def where_clause
      #   condition 'obsolete_on IS NULL'
      #   condition %(AND car_brand_id IN #{inop(car_brand_condition)}) if
      #     car_brand_condition
      # end

      def order_by_clause
        sort 1, :desc
        sort 'cb.id'
      end

      private

      # def car_brand_condition
      #   return unless car_brands

      #   %(SELECT id FROM car_brands WHERE name #{inop(car_brands)})
      # end
    end
  end
end
