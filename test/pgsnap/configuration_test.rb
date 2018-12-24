# frozen_string_literal: true

require 'test_helper'

class ConnectionTest < Minitest::Test
  def wrap_dbname_configuration
    initial_dbname = Pgsnap.configuration.dbname
    yield
    Pgsnap.set_configuration { |config| config.dbname = initial_dbname }
  end

  def test_that_initial_dbname_is_nil
    wrap_dbname_configuration do
      Pgsnap.reset_configuration
      assert_nil Pgsnap.configuration.dbname
    end
  end

  def test_that_user_can_configure_dbname
    wrap_dbname_configuration do
      Pgsnap.set_configuration do |config|
        config.dbname = 'yet_another_dbname'
      end

      assert_equal 'yet_another_dbname', Pgsnap.configuration.dbname
    end
  end
end
