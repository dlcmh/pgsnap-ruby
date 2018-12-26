# frozen_string_literal: true

module Pgsnap
  class PgResult
    def initialize(pg_result)
      @pg_result = pg_result
    end

    def columns
      (0..(number_of_columns - 1)).map { |idx| column_name(idx) }
    end

    def number_of_columns
      pg_result.nfields
    end

    def number_of_rows
      pg_result.ntuples
    end

    def result
      number_of_rows == 1 ? values.first : values
    end

    def values
      pg_result.values
    end

    private

    attr_reader :pg_result

    def column_name(idx)
      pg_result.fname(idx).to_sym
    end
  end
end
