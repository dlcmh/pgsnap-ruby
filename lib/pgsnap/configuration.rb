# frozen_string_literal: true

# http://lizabinante.com/blog/creating-a-configurable-ruby-gem/
module Pgsnap
  class << self
    # :reek:Attribute
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def reset_configuration
      @configuration = Configuration.new
    end

    def set_configuration
      yield(configuration)
    end
  end

  class Configuration
    # :reek:Attribute
    attr_accessor :dbname

    def initialize
      @dbname = nil # nil specifies that this config is required
    end
  end
end
