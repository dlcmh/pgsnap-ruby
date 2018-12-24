# frozen_string_literal: true

module Pgsnap
  class BaseTable
    attr_reader :table_name

    def initialize(table_name)
      @table_name = table_name
    end

    def columns
      Pgsnap::Query.new("SELECT * FROM #{table_name} WHERE false").columns
    end
  end
end
