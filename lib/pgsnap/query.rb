# frozen_string_literal: true

module Pgsnap
  class Query
    def initialize
      @cmd = Pgsnap::SelectCommand.new
      construct_command
    end

    def from(table_reference, table_reference_alias)
      cmd.from(table_reference, table_reference_alias)
    end

    def inner_join(table_reference, table_reference_alias, on:)
      cmd.inner_join(table_reference, table_reference_alias, on: on)
    end

    def select_command
      cmd.select_command
    end

    def select_list_item(expression, expression_alias = nil)
      cmd.select_list_item(expression, expression_alias)
    end

    def sort(sort_expression, direction = 'ASC')
      cmd.sort(sort_expression, direction)
    end

    def values(*expression)
      cmd.values(*expression)
    end

    private

    attr_reader :cmd

    def construct_command
      select_list
      table_expression
      order_by_clause
    end

    # optional
    def order_by_clause; end

    # optional
    def table_expression; end
  end
end
