# frozen_string_literal: true

module Examples
  module Queries
    module QueryIndex
      class << self
        def car_brands
          Examples::Queries::CarBrands.new.parenthesized_select_command
        end
      end
    end
  end
end
