# frozen_string_literal: true

require 'examples/pgsnap_config'

require 'examples/base_tables/car_models'
require 'examples/car_catalog_query'
require 'examples/pg_stat_activity_query'

module Examples
  class Error < StandardError; end
end
