# frozen_string_literal: true

module Pgsnap
  class BaseTable
    attr_reader :table_name

    def initialize(table_name:)
      @table_name = table_name.to_sym
    end

    def columns
      cached_columns || Pgsnap::TableColumnsCache.set do |cache|
        cache[table_name] = Pgsnap::Query.new(
          "SELECT * FROM #{table_name} WHERE false"
        ).columns
      end
    end

    private

    def cached_columns
      Pgsnap::TableColumnsCache.columns[table_name]
    end
  end
end
