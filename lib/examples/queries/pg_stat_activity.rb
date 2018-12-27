# frozen_string_literal: true

module Examples
  class PgStatActivity
    attr_reader :connection

    def initialize
      @connection = Pgsnap::Connection.new.connection
    end

    def query
      result.first['query']
    end

    private

    def result
      @result ||= connection.exec('SELECT * FROM pg_stat_activity')
    end
  end
end
