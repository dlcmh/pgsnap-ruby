# frozen_string_literal: true

module Examples
  module Queries
    class SubqueryExample < Pgsnap::Query
      CAR_MODELS = Examples::Queries::CarModels.new
                                               .parenthesized_select_command

      def select_list
        select_list_item 'car_models.year', :year
      end

      def table_expression
        from CAR_MODELS, :car_models
      end
    end
  end
end
