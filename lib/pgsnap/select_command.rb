# frozen_string_literal: true

module Pgsnap
  # :reek:TooManyMethods
  class SelectCommand
    attr_reader :command

    def initialize
      @_u = Pgsnap::Utils
      @command = {}
    end

    def from(table_reference, table_reference_alias)
      table_expression_struct << "#{table_reference} AS #{table_reference_alias}"
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

    def json_agg(nesting_definition)
      "JSON_AGG(#{nesting_definition})"
    end

    def relation(query_class, relation_alias)
      cmd.relation(query_class, relation_alias)
    end

    def select_command
      @select_command ||= stringified_command
    end

    def select_command_json
      "SELECT JSON_AGG(relation) FROM (#{select_command}) relation"
    end

    def select_list_item(expression, expression_alias)
      # handles 'table_name.*' expression
      return select_list_struct << expression if expression[/^.+\.(\*)$/, 1]

      raise Error, 'expression_alias cannot be empty' unless expression_alias

      select_list_struct << "#{expression} AS #{expression_alias}"
    end

    def sort(expression, direction = 'ASC')
      order_by_clause_struct << [expression, direction.upcase]
    end

    def values(*expression)
      squished = _u.squish(expression)
      wrapped_in_single_quotes = _u.wrap_in_single_quotes(squished)
      comma_joined = _u.join_with_comma(wrapped_in_single_quotes)
      "(VALUES(#{comma_joined}))"
    end

    private

    attr_reader :_u

    def limit_clause_struct
      command[:limit_clause] ||= []
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
      _u.join_with_space([
        _u.build_clause('SELECT', select_list_struct, ','),
        _u.build_clause('FROM', table_expression_struct, ' '),
        _u.build_clause('GROUP BY', group_by_clause_struct, ','),
        _u.build_clause(
          'ORDER BY',
          order_by_clause_struct.map { |item| item.join(' ') },
          ','
        ),
        _u.build_scalar('LIMIT', limit_clause_struct.first)
      ].compact)
    end

    def table_expression_struct
      command[:table_expression] ||= []
    end
  end
end
