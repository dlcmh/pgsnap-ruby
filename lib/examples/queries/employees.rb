# frozen_string_literal: true

module Examples
  module Queries
    class Employees < Pgsnap::Query
      def table_expression
        from :employees, :emp
      end

      def select_list
        select_list_item 'emp.employee_id', :employee_id
        select_list_item 'emp.full_name', :full_name
        select_list_item 'emp.manager_id', :manager_id
      end
    end
  end
end
