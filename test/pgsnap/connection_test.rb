# frozen_string_literal: true

require 'test_helper'

class ConnectionTest < Minitest::Test
  def test_that_it_can_connect
    assert_equal Pgsnap.configuration.dbname,
                 Pgsnap::Connection.new.dbname_from_status
  end
end
