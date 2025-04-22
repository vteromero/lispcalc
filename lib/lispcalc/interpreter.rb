require_relative 'context'
require_relative 'functions'

module Lispcalc
  class Interpreter
    def initialize(ctx = Context.new)
      @ctx = ctx
      @functions = Functions.new(ctx)
    end

    def eval_list(list)
      raise ArgumentError, 'expecting an instance of Array' unless list.instance_of?(Array)
      raise SyntaxError, 'empty list' if list.empty?

      fn, *args = list
      raise SyntaxError, 'the first element of a list must be a symbol' unless fn.instance_of?(Symbol)

      call(fn, eval_args(args))
    end

    alias eval eval_list

    def eval_symbol(symbol)
      @ctx[symbol] || symbol
    end

    private

    def eval_args(args)
      args.map do |arg|
        case arg
        when Array
          eval_list(arg)
        when Symbol
          eval_symbol(arg)
        when BigDecimal
          arg
        else
          raise UnknownFormError
        end
      end
    end

    def call(fn, args)
      if fn =~ />(.+)/
        @functions.send(:set_var, Regexp.last_match(1).to_sym, *args)
      elsif Functions.public_method_defined?(fn, false)
        @functions.send(fn, *args)
      else
        raise UnknownFunctionError, "undefined function '#{fn}'"
      end
    end
  end
end
