# frozen_string_literal: true

module Pgsnap
  class Query
    attr_reader :sql_command, :sql_command_wip, :select_list_wip

    def initialize(sql_command = nil)
      if sql_command
        @sql_command = sql_command
      else
        @sql_command_wip = []
        @select_list_wip = []
        construct_sql_command
        @sql_command = sql_command_wip.join(' ')
      end
    end

    def as_subquery
      "(#{sql_command})"
    end

    def construct_sql_command
      sql_command_wip << "SELECT"
      select_list
      sql_command_wip << select_list_wip.join(', ')
      table_expression
    end

    def from(table_reference, table_reference_alias)
      sql_command_wip << "FROM #{table_reference} AS #{table_reference_alias}"
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
        Pgsnap::Connection.new.connection.exec(sql_command)
    end
  end
end
