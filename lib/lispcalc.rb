require 'bigdecimal'
require 'bigdecimal/util'

require_relative 'lispcalc/errors'
require_relative 'lispcalc/interpreter'
require_relative 'lispcalc/lexer'
require_relative 'lispcalc/parser'
require_relative 'lispcalc/version'

module Lispcalc
  class << self
    def eval(input, ctx = Context.new)
      tokens = Lexer.tokenize(input)
      forms = Parser.new(tokens).parse
      Interpreter.new(ctx).eval(forms)
    end
  end
end
