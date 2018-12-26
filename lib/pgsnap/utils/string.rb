# frozen_string_literal: true

module Pgsnap
  module Utils
    refine Hash do
      def to_s
        ''
      end
    end

    class << self
      # '   i    wanna  be     squished'
      # => "i wanna be squished"
      #
      # [1, '   i    wanna  be     squished']
      # => [1, "i wanna be squished"]
      def squish(content)
        return content.split.join(' ') if content.is_a?(String)

        return content.map { |elem| squish(elem) } if content.is_a?(Array)

        content
      end

      def wrap_in_single_quotes(content)
        return %('#{content}') if content.is_a?(String)

        if content.is_a?(Array)
          return content.map { |elem| wrap_in_single_quotes(elem) }
        end

        content
      end
    end
  end
end
