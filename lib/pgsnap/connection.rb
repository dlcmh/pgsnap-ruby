# frozen_string_literal: true

module Pgsnap
  class Connection
    class << self
      def connect
        'hello - connect'
      end
    end
  end
end
