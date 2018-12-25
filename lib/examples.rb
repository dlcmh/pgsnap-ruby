# frozen_string_literal: true

require 'examples/pgsnap_config'

require 'examples/base_tables/car_models'

require 'examples/queries/car_catalog'
require 'examples/queries/pg_stat_activity'

module Examples
  class Error < StandardError; end
end
