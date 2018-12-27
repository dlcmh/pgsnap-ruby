# frozen_string_literal: true

module Pgsnap
  class SelectCommand
    attr_reader :command

    def initialize
      @util = Pgsnap::Utils
      @command = {}
    end

    def from(table_reference, table_reference_alias)
      table_expression << "#{table_reference} AS #{table_reference_alias}"
    end

    def inner_join(table_reference, table_reference_alias, on)
      table_expression <<
        "INNER JOIN #{table_reference} AS #{table_reference_alias} ON #{on}"
    end

    def select_command
      command.values.join(' ')
    end

    def select_command_json
      "SELECT ROW_TO_JSON(relation) FROM (#{select_command}) relation"
    end

    def select_list_item(expression, expression_alias = nil)
      # handles 'table_name.*' expression
      return select_list << expression if expression[/^.+\.(\*)$/, 1]

      raise Error, 'expression_alias cannot be empty' unless expression_alias

      select_list << "#{expression} AS #{expression_alias}"
    end

    def sort(sort_expression, direction = 'ASC')
      order_by_clause << "#{sort_expression} #{direction.upcase}"
    end

    def values(*expression)
      squished = util.squish(expression)
      wrapped_in_single_quotes = util.wrap_in_single_quotes(squished)
      comma_joined = util.join_with_comma(wrapped_in_single_quotes)
      "(VALUES(#{comma_joined}))"
    end

    private

    attr_reader :util

    def order_by_clause
      command[:order_by_clause] ||= ['ORDER_BY']
    end

    def select_list
      command[:select_list] ||= ['SELECT']
    end

    def table_expression
      command[:table_expression] ||= ['FROM']
    end
  end
end
