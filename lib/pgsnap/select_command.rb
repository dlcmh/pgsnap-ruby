# frozen_string_literal: true

module Pgsnap
  # :reek:TooManyMethods
  class SelectCommand
    attr_reader :command

    def initialize
      @_util = Pgsnap::Utils
      @command = {}
    end

    def from(table_reference, table_reference_alias)
      table_expression << "#{table_reference} AS #{table_reference_alias}"
    end

    def inner_join(table_reference, table_reference_alias, on)
      table_expression <<
        "INNER JOIN #{table_reference} AS #{table_reference_alias} ON #{on}"
    end

    def limit(number_of_rows)
      limit_clause << number_of_rows
    end

    def relation(query_class, relation_alias)
      cmd.relation(query_class, relation_alias)
    end

    def select_command
      @select_command ||= stringified_command
    end

    def select_command_json_array
      "SELECT JSON_AGG(relation) FROM (#{select_command}) relation"
    end

    def select_command_json_object
      "SELECT TO_JSON(relation) FROM (#{select_command}) relation"
    end

    def select_list_item(expression, expression_alias)
      # handles 'table_name.*' expression
      return select_list << expression if expression[/^.+\.(\*)$/, 1]

      raise Error, 'expression_alias cannot be empty' unless expression_alias

      select_list << "#{expression} AS #{expression_alias}"
    end

    def sort(sort_expression, direction = 'ASC')
      order_by_clause << "#{sort_expression} #{direction.upcase}"
    end

    def values(*expression)
      squished = _util.squish(expression)
      wrapped_in_single_quotes = _util.wrap_in_single_quotes(squished)
      comma_joined = _util.join_with_comma(wrapped_in_single_quotes)
      "(VALUES(#{comma_joined}))"
    end

    private

    attr_reader :_util

    def limit_clause
      command[:limit_clause] ||= []
    end

    def order_by_clause
      command[:order_by_clause] ||= []
    end

    def select_list
      command[:select_list] ||= []
    end

    def stringified_command
      [
        _util.build_clause('SELECT', select_list, ','),
        _util.build_clause('FROM', table_expression, ' '),
        _util.build_clause('ORDER BY', order_by_clause, ','),
        _util.build_scalar('LIMIT', limit_clause.first)
      ].compact.join(' ')
    end

    def table_expression
      command[:table_expression] ||= []
    end
  end
end
