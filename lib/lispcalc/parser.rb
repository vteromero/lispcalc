module Lispcalc
  class Parser
    def initialize(tokens)
      raise ArgumentError, 'expecting an Array' unless tokens.instance_of?(Array)
      raise ArgumentError, 'invalid token' unless tokens.all? { |t| valid_token?(t) }

      @tokens = tokens
    end

    def parse
      output = parse_list
      raise SyntaxError, 'expecting a single top-level list' unless @tokens.empty?

      output
    end

    private

    def valid_token?(token)
      token.instance_of?(Array) &&
        token[0].instance_of?(Symbol) &&
        (token[1].nil? || token[1].instance_of?(String))
    end

    def peek
      @tokens.first
    end

    def next_token
      @tokens.shift
    end

    def parse_list
      return nil if @tokens.empty?
      raise SyntaxError, "expecting '('" unless next_token[0] == :open_paren

      list = []

      until @tokens.empty?
        if peek[0] == :open_paren
          list << parse_list
        else
          token = next_token
          case token[0]
          when :close_paren
            return list
          when :symbol
            list << parse_symbol(token[1])
          when :number
            list << parse_number(token[1])
          else
            raise UnknownTokenError
          end
        end
      end

      raise SyntaxError, "unclosed list; expecting ')'"
    end

    def parse_symbol(str)
      str.to_sym
    end

    def parse_number(str)
      BigDecimal(str)
    end
  end
end
