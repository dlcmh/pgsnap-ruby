# frozen_string_literal: true

module Examples
  module Queries
    class CarCatalog < Pgsnap::Query
      def select_list
        select_list_item 'cm.year', :year
        select_list_item 'cm.name', :name
      end

      def table_expression
        from :car_models, :cm
        # inner_join :car_brands
        # on car_models.c(car_brand_id), '=', car_brands.c(id)
      end
    end
  end
end
