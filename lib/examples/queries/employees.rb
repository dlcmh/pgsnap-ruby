# frozen_string_literal: true

module Examples
  module Queries
    class Employees < Pgsnap::Query
      def table_expression
        from :employees, :emp
      end

      def select_list
        column 'emp.employee_id', :employee_id
        column 'emp.full_name', :full_name
        column 'emp.manager_id', :manager_id
      end
    end
  end
end
