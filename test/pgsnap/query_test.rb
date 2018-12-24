# frozen_string_literal: true

require 'test_helper'

class QueryTest < Minitest::Test
  def test_that_select_1_returns_1
    assert_equal 1, Pgsnap::Query.with('SELECT 1 AS one, 2 AS two, 3 AS three')
  end
end
