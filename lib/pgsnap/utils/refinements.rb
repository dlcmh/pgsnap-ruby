# frozen_string_literal: true

module Pgsnap
  module Utils
    module Refinements
      refine String do
        def parens_wrapped
          "(#{self})"
        end
      end
    end
  end
end
