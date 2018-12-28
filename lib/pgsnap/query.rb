# frozen_string_literal: true

require 'json'

module Pgsnap
  # :reek:TooManyMethods
  class Query
    def initialize
      construct_command
    end

    # Results
    ##

    # Executes a new instance of query on PostgreSQL and caches result
    def json
      @json ||= Pgsnap::PgResult.new(select_command_json).array_of_hashes
    end

    def json_string
      @json_string ||= json.to_json
    end

    # Executes a new instance of query on PostgreSQL and caches result
    def result
      @result ||= Pgsnap::PgResult.new(select_command).native
    end

    # SELECT commands
    ##

    def as_subquery
      _u.wrap_in_parentheses(select_command)
    end

    def select_command
      _c.select_command
    end

    def select_command_json
      _c.select_command_json
    end

    def select_command_json_string
      _c.select_command_json_string
    end


    # command struct
    def command
      _c.command
    end

    # Commands
    ##

    def from(table_reference, table_reference_alias)
      _c.from(table_reference, table_reference_alias)
    end

    def inner_join(table_reference, table_reference_alias, on:)
      _c.inner_join(table_reference, table_reference_alias, on)
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

    def relation(query_class, relation_alias = nil)
      _c.relation(query_class, relation_alias)
    end

    def select_list_item(expression, expression_alias = nil)
      _c.select_list_item(expression, expression_alias)
    end

    def sort(sort_expression, direction = 'ASC')
      _c.sort(sort_expression, direction)
    end

    def values(*expression)
      _c.values(*expression)
    end

    private

    # constructs query from methods defined in subclass
    def construct_command
      select_list
      table_expression
      group_by_clause
      order_by_clause
    end

    # optional
    ##

    def group_by_clause; end

    def order_by_clause; end

    def table_expression; end

    # aliases
    ##

    def _c
      @_c ||= Pgsnap::SelectCommand.new
    end

    def _u
      @_u ||= Pgsnap::Utils
    end
  end
end
