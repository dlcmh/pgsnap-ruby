# frozen_string_literal: true

require 'json'

module Pgsnap
  # :reek:TooManyMethods
  class Query
    def initialize
      @qb = Pgsnap::QueryBuilder.new
      @util = Pgsnap::Utils
      construct_command
    end

    # Results
    ##

    # Executes a new instance of query on PostgreSQL
    def json
      pgresult_instance(select_command_json).array_of_hashes
    end

    def json_string
      json.to_json
    end

    # Executes a new instance of query on PostgreSQL
    def result
      pgresult_instance(select_command).native
    end

    # SELECT commands
    ##

    def as_subquery
      util.wrap_in_parentheses(select_command)
    end

    def select_command
      qb.select_command
    end

    def select_command_json
      qb.select_command_json
    end

    def select_command_json_string
      qb.select_command_json_string
    end


    # Metadata
    ##

    # command struct
    def command
      qb.command
    end

    def columns
      raise Error, 'Query has not executed yet' unless pgresult

      pgresult.columns
    end

    def dbname
      Pgsnap.configuration.dbname
    end

    # Setters
    ##

    def condition(expression)
      qb.condition(expression)
    end

    def from(table_reference, table_reference_alias)
      qb.from(table_reference, table_reference_alias)
    end

    def inner_join(table_reference, table_reference_alias, on:)
      qb.inner_join(table_reference, table_reference_alias, on)
    end

    def group(group_expression)
      qb.group(group_expression)
    end

    def json_agg(nesting_definition)
      qb.json_agg(nesting_definition)
    end

    def limit(number_of_rows)
      qb.limit(number_of_rows)
    end

    def literal(query_string)
      qb.literal(query_string)
    end

    def relation(query_class, relation_alias = nil)
      qb.relation(query_class, relation_alias)
    end

    def column(expression, expression_alias = nil)
      qb.column(expression, expression_alias)
    end

    def sort(sort_expression, direction = 'ASC')
      qb.sort(sort_expression, direction)
    end

    def values(*expression)
      qb.values(*expression)
    end

    # Operators
    ##

    def inop(values)
      "IN (#{util.in_operator(values)})"
    end

    private

    attr_reader :pgresult, :qb, :util

    # constructs query from methods defined in subclass
    def construct_command
      select_list
      table_expression
      where_clause
      group_by_clause
      order_by_clause
    end

    # optional
    ##

    def group_by_clause; end

    def order_by_clause; end

    def table_expression; end

    def where_clause; end

    # metadata
    ##

    def pgresult_instance(select_command)
      @pgresult = Pgsnap::PgResult.new(select_command)
      pgresult
    end
  end
end
