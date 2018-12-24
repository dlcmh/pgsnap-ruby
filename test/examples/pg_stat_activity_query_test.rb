# frozen_string_literal: true

require 'test_helper'

class PgStatActivityQueryTest < Minitest::Test
  attr_reader :connection, :select_statement

  def setup
    @select_statement = Examples::PgStatActivityQuery::SELECT_STATEMENT
    @connection = Examples::PgStatActivityQuery.new
  end

  def test_query
    assert_equal select_statement, connection.query
  end
end
