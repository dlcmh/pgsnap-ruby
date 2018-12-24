# frozen_string_literal: true

require 'pgsnap/version'
require 'pgsnap/connection'

module Pgsnap
  class Error < StandardError; end

  Connection.new
end
