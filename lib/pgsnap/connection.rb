# frozen_string_literal: true

require 'pg'

module Pgsnap
  class Connection
    attr_reader :connection, :dbname

    def initialize
      @dbname = Pgsnap.configuration.dbname
      connect
    end

    def connect
      @connection = PG.connect(dbname: dbname).tap do |conn|
        # # (A)
        # # otherwise, all values are returned as strings
        # # https://github.com/ged/ruby-pg#type-casts
        # # got Warning: no type cast defined for type "xid" with oid 28.
        # #   Please cast this type explicitly to TEXTto be safe for future
        # #   changes.
        # # => so, used (B)
        # conn.type_map_for_results = PG::BasicTypeMapForResults.new(conn)

        # (B)
        # https://stackoverflow.com/questions/34795078/
        #   pg-gem-warning-no-type-cast-defined-for-type-numeric/
        #   51882462#51882462
        map = PG::BasicTypeMapForResults.new(conn)
        map.default_type_map = PG::TypeMapAllStrings.new
        conn.type_map_for_results = map
      end
    end

    def dbname_from_status
      status[0]['datname']
    end

    def status
      connection.exec('SELECT * FROM pg_stat_activity')
    end
  end
end
