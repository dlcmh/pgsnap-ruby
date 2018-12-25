# frozen_string_literal: true

module Examples
  module Queries
    class CarModels < Pgsnap::Query
      def select_list
        select_list_item 'cm.year', :year
        select_list_item 'cm.name', :name
      end

      def table_expression
        from :car_models, :cm
      end
    end
  end
end
