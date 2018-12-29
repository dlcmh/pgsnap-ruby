# frozen_string_literal: true

module Examples
  module Queries
    class BaseTables < Pgsnap::Query
      def select_list
        literal %(
          SELECT table_name
          FROM information_schema.tables
          WHERE table_schema='public' AND table_type='BASE TABLE'
        )
      end
    end
  end
end
