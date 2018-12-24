# frozen_string_literal: true

module Examples
  class PgStatActivity
    SELECT_STATEMENT = 'SELECT * FROM pg_stat_activity'

    attr_reader :conn

    def initialize(dbname)
      @conn = Pgsnap::Connection.new(dbname).conn
    end

    def query
      result.first['query']
    end

    private

    def result
      @result ||= conn.exec(SELECT_STATEMENT)
    end
  end
end
