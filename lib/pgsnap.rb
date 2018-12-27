# frozen_string_literal: true

require 'pgsnap/version'

require 'pgsnap/configuration'

require 'pgsnap/utils'

require 'pgsnap/connection'
require 'pgsnap/base_table'
require 'pgsnap/pg_result'
require 'pgsnap/select_command'
require 'pgsnap/query'
require 'pgsnap/table_columns_cache'

module Pgsnap
  class Error < StandardError; end

  Pgsnap.set_configuration do |config|
    config.dbname = 'pgsnap'
  end
end
