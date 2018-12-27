# frozen_string_literal: true

module Pgsnap
  # :reek:TooManyMethods
  class Query
    def initialize
      @_cmd = Pgsnap::SelectCommand.new
      @_result = Pgsnap::PgResult
      @_util = Pgsnap::Utils
      construct_command
    end

    def from(table_reference, table_reference_alias)
      _cmd.from(table_reference, table_reference_alias)
    end

    def inner_join(table_reference, table_reference_alias, on:)
      _cmd.inner_join(table_reference, table_reference_alias, on)
    end

    def json_array_result
      @json_array_result ||= _result.new(select_command_json_array).json_result
    end

    def json_object_result
      @json_object_result ||=
        _result.new(select_command_json_object).json_result
    end

    def limit(number_of_rows)
      _cmd.limit(number_of_rows)
    end

    def native_result
      @native_result ||= _result.new(select_command).native_result
    end

    def relation(query_class, relation_alias = nil)
      _cmd.relation(query_class, relation_alias)
    end

    def select_command
      _cmd.select_command
    end

    def select_command_json_array
      _cmd.select_command_json_array
    end

    def select_command_json_object
      _cmd.select_command_json_object
    end

    def select_list_item(expression, expression_alias = nil)
      _cmd.select_list_item(expression, expression_alias)
    end

    def sort(sort_expression, direction = 'ASC')
      _cmd.sort(sort_expression, direction)
    end

    def parenthesized_select_command
      _util.wrap_in_parentheses(select_command)
    end

    def values(*expression)
      _cmd.values(*expression)
    end

    private

    attr_reader :_cmd, :_result, :_util

    def construct_command
      select_list
      table_expression
      order_by_clause
    end

    # start: optional
    def order_by_clause; end

    def table_expression; end
    # end: optional
  end
end
