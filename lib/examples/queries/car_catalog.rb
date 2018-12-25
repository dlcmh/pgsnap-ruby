# frozen_string_literal: true

module Examples
  module Queries
    class CarCatalog < Pgsnap::Query
      def table_expression
        from :car_brands, :cb
        inner_join :car_models, :cm, on: 'cb.id = cm.car_brand_id'
      end

      def select_list
        select_list_item 'cb.name', :brand
        select_list_item 'cm.year', :year
        select_list_item 'cm.name', :name
      end
    end
  end
end
