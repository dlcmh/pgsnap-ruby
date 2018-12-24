# frozen_string_literal: true

require 'test_helper'

class BaseTableTest < Minitest::Test
  TEST_TABLE_NAME = 'car_models'

  attr_reader :table

  def setup
    @table = Pgsnap::BaseTable.new(TEST_TABLE_NAME)
  end

  def test_that_table_name_can_be_retrieved_from_the_database
    assert_equal TEST_TABLE_NAME, table.table
  end
end
