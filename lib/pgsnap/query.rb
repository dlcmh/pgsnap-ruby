# frozen_string_literal: true

module Pgsnap
  # :reek:TooManyMethods
  class Query
    def initialize
      @_c = Pgsnap::SelectCommand.new
      @_r = Pgsnap::PgResult
      @_u = Pgsnap::Utils
      construct_command
    end

    def command
      _c.command
    end

    def from(table_reference, table_reference_alias)
      _c.from(table_reference, table_reference_alias)
    end

    def inner_join(table_reference, table_reference_alias, on:)
      _c.inner_join(table_reference, table_reference_alias, on)
    end

    def array_of_hashes
      @array_of_hashes ||= _r.new(select_command_json).array_of_hashes
    end

    def group(group_expression)
      _c.group(group_expression)
    end

    def json_agg(nesting_definition)
      _c.json_agg(nesting_definition)
    end

    def limit(number_of_rows)
      _c.limit(number_of_rows)
    end

    def native_result
      @native_result ||= _r.new(select_command).native_result
    end

    def relation(query_class, relation_alias = nil)
      _c.relation(query_class, relation_alias)
    end

    def select_command
      _c.select_command
    end

    def select_command_json
      _c.select_command_json
    end

    def select_list_item(expression, expression_alias = nil)
      _c.select_list_item(expression, expression_alias)
    end

    def sort(sort_expression, direction = 'ASC')
      _c.sort(sort_expression, direction)
    end

    def as_subquery
      _u.wrap_in_parentheses(select_command)
    end

    def values(*expression)
      _c.values(*expression)
    end

    private

    attr_reader :_c, :_r, :_u

    def construct_command
      select_list
      table_expression
      group_by_clause
      order_by_clause
    end

    # start: optional
    def group_by_clause; end

    def order_by_clause; end

    def table_expression; end
    # end: optional
  end
end
