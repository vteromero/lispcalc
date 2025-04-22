module Lispcalc
  class Lexer
    WS = /\A\s+/.freeze
    OPEN_PAREN = /\A\(/.freeze
    CLOSE_PAREN = /\A\)/.freeze
    NUMBER = /\A[+-]?([0-9]*[.])?[0-9]+/.freeze
    SYMBOL = /\A[+\-*\/>a-zA-Z][+\-*\/>a-zA-Z0-9]*/.freeze # TODO: review this regexp

    def initialize(input)
      @input = input
    end

    def next_token
      if @input =~ WS
        advance(Regexp.last_match(0).length)
      end

      return nil if @input.empty?

      case @input
      when OPEN_PAREN
        advance
        [:open_paren]
      when CLOSE_PAREN
        advance
        [:close_paren]
      when NUMBER
        number = Regexp.last_match(0)
        advance(number.length)
        [:number, number]
      when SYMBOL
        symbol = Regexp.last_match(0)
        advance(symbol.length)
        [:symbol, symbol]
      else
        raise UnknownTokenError
      end
    end

    def self.tokenize(input)
      tokens = []
      lexer = Lexer.new(input)
      while (token = lexer.next_token)
        tokens << token
      end
      tokens
    end

    private

    def advance(steps = 1)
      @input = @input[steps..]
    end
  end
end
