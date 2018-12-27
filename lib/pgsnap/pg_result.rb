# frozen_string_literal: true

module Pgsnap
  class PgResult
    def initialize(select_command)
      @select_command = select_command
      set_pg_result
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

    def json_result
      native_result.first
    end

    def native_result
      number_of_rows == 1 ? values.first : values
    end

    def values
      pg_result.values
    end

    private

    attr_reader :pg_result, :select_command

    def column_name(idx)
      pg_result.fname(idx).to_sym
    end

    def set_pg_result
      pg_result || @pg_result = Pgsnap::Connection.new.connection.exec(
        select_command
      )
    end
  end
end
