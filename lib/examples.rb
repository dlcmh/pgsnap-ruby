# frozen_string_literal: true

require 'examples/pgsnap_config'

require 'examples/base_tables/car_models'

require 'examples/queries/car_brands'
require 'examples/queries/car_brands_as_json_array'
require 'examples/queries/car_brands_as_json_object'
require 'examples/queries/car_catalog'
require 'examples/queries/car_models'
require 'examples/queries/employees'
require 'examples/queries/pg_stat_activity'
require 'examples/queries/single_row_values'
require 'examples/queries/subquery_example'

module Examples
  class Error < StandardError; end
end
