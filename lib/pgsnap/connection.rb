# frozen_string_literal: true

require 'pg'

module Pgsnap
  class Connection
    attr_reader :conn, :dbname

    def initialize(dbname)
      @dbname = dbname
      connect
    end

    def connect
      @conn = PG.connect(dbname: dbname)
    end

    def dbname_from_status
      status[0]['datname']
    end

    def status
      conn.exec('SELECT * FROM pg_stat_activity')
    end
  end
end
