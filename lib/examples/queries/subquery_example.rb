# frozen_string_literal: true

module Examples
  module Queries
    class SubqueryExample < Pgsnap::Query
      CAR_MODELS = Examples::Queries::CarModels.new.as_subquery

      def select_list
        column 'car_models.year', :year
      end

      def table_expression
        from CAR_MODELS, :car_models
      end
    end
  end
end
