# frozen_string_literal: true

module Examples
  module Queries
    class CarModelsNestedByCarBrandId < Pgsnap::Query
      class Nesting < Pgsnap::NestedJson
        def select_list
          column 'cm.year', :year
          column 'cm.name', :name
        end

        def order_by_clause
          sort 'cm.year', :desc
          sort 'cm.name'
        end
      end

      def table_expression
        from :car_models, :cm
      end

      def select_list
        column 'cm.car_brand_id', :car_brand_id
        column json_agg(Nesting.new.nesting), :models
      end

      def group_by_clause
        group 1
      end
    end
  end
end
