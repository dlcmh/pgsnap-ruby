# frozen_string_literal: true

module Examples
  class PgStatActivity
    SELECT_STATEMENT = 'SELECT * FROM pg_stat_activity'

    attr_reader :connection

    def initialize
      @connection = Pgsnap::Connection.new.connection
    end

    def query
      result.first['query']
    end

    private

    def result
      @result ||= connection.exec(SELECT_STATEMENT)
    end
  end
end
