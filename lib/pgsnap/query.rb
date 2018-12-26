# frozen_string_literal: true

module Pgsnap
  # :reek:TooManyInstanceVariables
  class Query
    attr_reader :pg_result, :pg_result_values, :select_command,
                :select_command_wip, :select_list_wip, :sort_list_wip

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

    def construct_select_list
      select_list
      select_command_wip << select_list_wip.join(', ')
    end

    def construct_select_command
      select_command_wip << 'SELECT'
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

    def result
      return pg_result_values if pg_result_values

      set_pg_result
      pg_result_values
    end

    private

    def pgu
      @pgu ||= Pgsnap::Utils
    end

    def select_list_item(expression, expression_alias = nil)
      # handles 'table_name.*' expression
      return select_list_wip << expression if expression[/^.+\.(\*)$/, 1]

      raise Error, 'expression_alias cannot be empty' unless expression_alias

      select_list_wip << "#{expression} AS #{expression_alias}"
    end

    def set_pg_result
      @pg_result = Pgsnap::PgResult.new(
        Pgsnap::Connection.new.connection.exec(select_command)
      )
      @pg_result_values = pg_result.result
    end

    def values(*expression)
      squished = pgu.squish(expression)
      wrapped_in_single_quotes = pgu.wrap_in_single_quotes(squished)
      comma_joined = pgu.join_with_comma(wrapped_in_single_quotes)
      "(VALUES(#{comma_joined}))"
    end
  end
end
