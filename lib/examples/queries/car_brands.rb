# frozen_string_literal: true

module Examples
  module Queries
    class CarBrands < Pgsnap::Query
      def select_list
        select_list_item 'cb.name', :name
      end

      def table_expression
        from :car_brands, :cb
      end
    end
  end
end
