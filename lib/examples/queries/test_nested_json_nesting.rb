# frozen_string_literal: true

module Examples
  module Queries
    class TestNestedJsonNesting < Pgsnap::NestedJson
      def select_list
        select_list_item 'cm.year', :year
        select_list_item 'cm.name', :name
      end

      def order_by_clause
        sort 'cm.year', :desc
        sort 'cm.name'
      end
    end
  end
end
