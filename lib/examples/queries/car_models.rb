# frozen_string_literal: true

module Examples
  module Queries
    class CarModels < Pgsnap::Query
      def select_list
        column 'cm.year', :year
        column 'cm.name', :name
      end

      def table_expression
        from :car_models, :cm
      end

      def order_by_clause
        sort 1
        sort 2, :desc
      end

      def result
        array_of_hashes
      end
    end
  end
end
