# frozen_string_literal: true

module Pgsnap
  class Query
    attr_reader :select_command, :select_command_wip,
                :select_list_wip, :sort_list_wip

    def initialize(select_command = nil)
      if select_command
        @select_command = select_command
      else
        @select_command_wip = []
        @select_list_wip = []
        @sort_list_wip = []
        construct_select_command
        @select_command = select_command_wip.join(' ')
      end
    end

    # Start: optional - ORDER BY
    def order_by_clause; end

    def construct_order_by_clause
      return unless order_by_clause
      select_command_wip << "ORDER BY #{sort_list_wip.join(', ')}"
    end
    # End: optional - ORDER BY

    def as_subquery
      "(#{select_command})"
    end

    # Start: SELECT list
    def construct_select_list
      select_list
      select_command_wip << select_list_wip.join(', ')
    end
    # End: SELECT list

    def as_subquery
      "(#{select_command})"
    end

    def construct_select_command
      select_command_wip << "SELECT"
      construct_select_list
      table_expression
      construct_order_by_clause
    end

    def from(table_reference, table_reference_alias)
      select_command_wip <<
        "FROM #{table_reference} AS #{table_reference_alias}"
    end

    def sort(sort_expression, direction = 'ASC')
      sort_list_wip << "#{sort_expression} #{direction.upcase}"
    end

    def inner_join(table_reference, table_reference_alias, on:)
      select_command_wip <<
        "INNER JOIN #{table_reference} AS #{table_reference_alias} ON #{on}"
    end

    def select_list_item(expression, expression_alias = nil)
      return expression if expression[/^.+\.(\*)$/, 1] # table_name.* expression
      raise Error, 'expression_alias cannot be empty' unless expression_alias
      select_list_wip << "#{expression} AS #{expression_alias}"
    end

    def execute
      @pg_result ||= Pgsnap::PgResult.new(
        Pgsnap::Connection.new.connection.exec(select_command)
      )
    end

    private

    attr_reader :pg_result
  end
end
