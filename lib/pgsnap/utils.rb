# frozen_string_literal: true

module Pgsnap
  module Utils
    class << self
      def build_clause(clause, content_array, separator)
        return unless content_array.length.positive?

        pretty_separator = "#{separator} " unless separator == ' '
        "#{clause} #{content_array.join(pretty_separator)}"
      end

      def build_scalar(clause, content)
        "#{clause} #{content}" if content
      end

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

      def wrap_in_parentheses(content)
        "(#{content})"
      end

      # [1, 'i wanna be wrapped in single quotes']
      # => [1, "'i wanna be wrapped in single quotes'"]
      def wrap_in_single_quotes(content)
        return %('#{content}') if content.is_a?(String)

        if content.is_a?(Array)
          return content.map { |elem| wrap_in_single_quotes(elem) }
        end

        content
      end

      # [1, "'i wanna be wrapped in single quotes'"]
      # => "1, 'i wanna be wrapped in single quotes'"
      def join_with_comma(content)
        return content.join(', ') if content.is_a?(Array)

        content
      end
    end
  end
end
