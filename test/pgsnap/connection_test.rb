# frozen_string_literal: true

require 'test_helper'

class PgsnapTest < Minitest::Test
  def setup
    @connection = Pgsnap::Connection.new(dbname)
  end

  def dbname
    'drills-api_development'
  end

  def test_that_it_can_connect
    assert_equal dbname, @connection.dbname_from_status
  end
end
