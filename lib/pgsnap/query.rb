# frozen_string_literal: true

module Pgsnap
  PGU = Pgsnap::Utils

  # :reek:TooManyInstanceVariables
  class Query
    attr_reader :pg_result, :pg_result_values,
                :pg_result_json, :pg_result_json_body,
                :select_command, :select_command_wip, :select_list_wip,
                :sort_list_wip

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

    def select_command_json
      "SELECT ROW_TO_JSON(rel) FROM (#{select_command}) rel"
    end

    def json
      return pg_result_json if pg_result_json

      @pg_result_json = Pgsnap::PgResult.new(select_command_json)
      @pg_result_json_body = pg_result_json.result
    end

    def result
      return pg_result if pg_result

      @pg_result = Pgsnap::PgResult.new(select_command)
      @pg_result_values = pg_result.result
    end

    private

    def select_list_item(expression, expression_alias = nil)
      # handles 'table_name.*' expression
      return select_list_wip << expression if expression[/^.+\.(\*)$/, 1]

      raise Error, 'expression_alias cannot be empty' unless expression_alias

      select_list_wip << "#{expression} AS #{expression_alias}"
    end

    def values(*expression)
      squished = PGU.squish(expression)
      wrapped_in_single_quotes = PGU.wrap_in_single_quotes(squished)
      comma_joined = PGU.join_with_comma(wrapped_in_single_quotes)
      "(VALUES(#{comma_joined}))"
    end
  end
end
