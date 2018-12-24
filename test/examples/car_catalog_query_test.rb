# frozen_string_literal: true

require 'test_helper'

class CarCatalogQueryTest < Minitest::Test
  attr_reader :select_statement

  def setup
    @query = Examples::CarCatalogQuery.new
  end

  def test_json
    assert_equal 'hello', @query.json
  end
end
