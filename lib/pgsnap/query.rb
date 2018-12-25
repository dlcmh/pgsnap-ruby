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

    def as_subquery
      "(#{select_command})"
    end

    def construct_select_command
      select_command_wip << "SELECT"
      select_list
      select_command_wip << select_list_wip.join(', ')
      table_expression
      order_by_clause
      select_command_wip <<
        "ORDER BY #{sort_list_wip.join(', ')}"
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

    def select_list_item(expression, expression_alias)
      select_list_wip << "#{expression} AS #{expression_alias}"
    end

    def column_name(idx)
      query_execution_result.fname(idx).to_sym
    end

    def columns
      (0..(number_of_columns - 1)).map { |idx| column_name(idx) }
    end

    def number_of_columns
      query_execution_result.nfields
    end

    def number_of_rows
      query_execution_result.ntuples
    end

    def result
      number_of_rows == 1 ? values.first : values
    end

    def values
      query_execution_result.values
    end

    def query_execution_result
      @query_execution_result ||=
        Pgsnap::Connection.new.connection.exec(select_command)
    end
  end
end
