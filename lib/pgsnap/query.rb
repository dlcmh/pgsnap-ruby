# frozen_string_literal: true

module Pgsnap
  class Query
    attr_reader :select_statement

    def initialize(select_statement)
      @select_statement = select_statement
    end

    def column_name(idx)
      query_execution_result.fname(idx)
    end

    def columns
      (0..(number_of_columns - 1)).map { |idx| column_name(idx) }
    end

    def number_of_columns
      query_execution_result.nfields
    end

    def number_of_rows
      query_execution_result.ntuples
    end

    def result
      number_of_rows == 1 ? values.first : values
    end

    def values
      query_execution_result.values
    end

    def query_execution_result
      @query_execution_result ||=
        Pgsnap::Connection.new.connection.exec(select_statement)
    end
  end
end
