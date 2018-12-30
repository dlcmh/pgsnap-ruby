# frozen_string_literal: true

module Pgsnap
  # :reek:TooManyMethods
  class QueryBuilder
    attr_reader :command

    def initialize
      @util = Pgsnap::Utils
      @command = {}
    end

    # SELECT commands
    ##

    def select_command
      literal_query_string || stringified_command
    end

    def select_command_json
      "SELECT JSON_AGG(relation) FROM (#{select_command}) relation"
    end

    # Setters

    def condition(expression)
      where_clause_struct << expression
    end

    def from(table_reference, table_reference_alias)
      table_expression_struct <<
        "#{table_reference} AS #{table_reference_alias}"
    end

    def group(expression)
      group_by_clause_struct << expression
    end

    def inner_join(table_reference, table_reference_alias, on)
      table_expression_struct <<
        "INNER JOIN #{table_reference} AS #{table_reference_alias} ON #{on}"
    end

    def limit(number_of_rows)
      limit_clause_struct << number_of_rows
    end

    def literal(query_string)
      literal_query_string_struct << query_string
    end

    def json_agg(nesting_definition)
      "JSON_AGG(#{nesting_definition})"
    end

    def relation(query_class, relation_alias)
      cmd.relation(query_class, relation_alias)
    end

    def column(expression, expression_alias)
      # handles 'table_name.*' expression
      return select_list_struct << expression if expression[/^.+\.(\*)$/, 1]

      raise Error, 'expression_alias cannot be empty' unless expression_alias

      select_list_struct << "#{expression} AS #{expression_alias}"
    end

    def sort(expression, direction = 'ASC')
      order_by_clause_struct << [expression, direction.upcase]
    end

    def values(*expression)
      squished = util.squish(expression)
      wrapped_in_single_quotes = util.wrap_in_single_quotes(squished)
      comma_joined = util.join_with_comma(wrapped_in_single_quotes)
      "(VALUES(#{comma_joined}))"
    end

    private

    attr_reader :util

    def limit_clause_struct
      command[:limit_clause] ||= []
    end

    def literal_query_string
      command[:literal_query_string].join if
        literal_query_string_struct.size > 0
    end

    def literal_query_string_struct
      command[:literal_query_string] ||= []
    end

    def group_by_clause_struct
      command[:group_by_clause] ||= []
    end

    def order_by_clause_struct
      command[:order_by_clause] ||= []
    end

    def select_list_struct
      command[:select_list] ||= []
    end

    def stringified_command
      util.join_with_space([
        util.build_clause('SELECT', select_list_struct, ','),
        util.build_clause('FROM', table_expression_struct, ' '),
        util.build_clause('WHERE', where_clause_struct, ' '),
        util.build_clause('GROUP BY', group_by_clause_struct, ','),
        util.build_clause(
          'ORDER BY',
          order_by_clause_struct.map { |item| item.join(' ') },
          ','
        ),
        util.build_scalar('LIMIT', limit_clause_struct.first)
      ].compact)
    end

    def table_expression_struct
      command[:table_expression] ||= []
    end

    def where_clause_struct
      command[:where_clause] ||= []
    end
  end
end
