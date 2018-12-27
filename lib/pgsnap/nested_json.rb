# frozen_string_literal: true

module Pgsnap
  class NestedJson
    attr_reader :command

    def initialize
      @_u = Pgsnap::Utils
      @command = {}
      construct_command
    end

    def nesting
      @nesting ||= stringified_command
    end

    def order_by_clause; end

    def select_list_item(expression, expression_alias)
      # handles 'table_name.*' expression
      raise(
        Error,
        'select list item cannot be * columns in a nested JSON select command'
      ) if expression[/^.+\.(\*)$/, 1]

      raise Error, 'expression_alias cannot be empty' unless expression_alias

      select_list_struct << "#{expression} AS #{expression_alias}"
    end

    def sort(expression, direction = 'ASC')
      order_by_clause_struct << [expression, direction.upcase]
    end

    private

    attr_reader :_u

    def construct_command
      select_list
      order_by_clause
    end

    def order_by_clause_struct
      command[:order_by_clause] ||= []
    end

    def select_list_struct
      command[:select_list] ||= []
    end

    def stringified_command
      a = _u.wrap_in_parentheses(
        _u.build_clause('SELECT', select_list_struct, ',')
      )
      b = _u.join_with_space([
        'SELECT x FROM',
        a,
        'AS x'
      ].compact)
      c = _u.wrap_in_parentheses(b)
      _u.join_with_space([
        c,
        _u.build_clause(
          'ORDER BY',
          order_by_clause_struct.map { |item| item.join(' ') },
          ','
        )
        ].compact)
    end
  end
end
