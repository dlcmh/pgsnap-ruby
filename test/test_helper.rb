# frozen_string_literal: true

require 'pgsnap'
require 'examples'

require 'minitest/autorun'

Pgsnap.set_configuration do |config|
  config.dbname = 'pgsnap'
end
