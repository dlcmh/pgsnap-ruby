# frozen_string_literal: true

require 'test_helper'

class ExamplesTest < Minitest::Test
  attr_reader :conn, :select_statement

  def setup
    @select_statement = Examples::PgStatActivity::SELECT_STATEMENT
    @conn = Examples::PgStatActivity.new(DBNAME)
  end

  def test_query
    assert_equal select_statement, @conn.query
  end
end
