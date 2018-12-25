# frozen_string_literal: true

# caches table columns queried from the database
module Pgsnap
  class TableColumnsCache
    class << self
      # :reek:Attribute
      attr_writer :cache

      def cache
        @cache ||= new
      end

      def columns
        cache.columns
      end

      def set
        yield(cache.columns)
      end
    end

    # :reek:Attribute
    attr_accessor :columns

    def initialize
      @columns = {}
    end
  end
end
