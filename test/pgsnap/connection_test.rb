# frozen_string_literal: true

require 'test_helper'

class PgsnapTest < Minitest::Test
  def setup
    @conn = Pgsnap::Connection.new(DBNAME)
  end

  def test_that_it_can_connect
    assert_equal DBNAME, @conn.dbname_from_status
  end
end
