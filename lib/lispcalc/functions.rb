module Lispcalc
  class Functions
    def initialize(ctx)
      @ctx = ctx
    end

    def +(*args)
      arithmetic_op(:+, args)
    end

    def -(*args)
      arithmetic_op(:-, args)
    end

    def *(*args)
      arithmetic_op(:*, args)
    end

    def /(*args)
      arithmetic_op(:/, args)
    end

    def do(*args)
      args.last unless args.empty?
    end

    private

    def arithmetic_op(op, args)
      raise ArgumentError, "expecting at least 2 arguments, receiving #{args.size}" unless args.size >= 2
      raise ArgumentError, 'expecting all arguments to be BigDecimal' unless args.all?(BigDecimal)

      args.inject(op)
    end

    def set_var(name, value)
      raise ContextError, "trying to change the value of the constant '#{name}'" if @ctx.const?(name)
      raise ContextError, "undefined variable '#{name}'" unless @ctx.var?(name)

      @ctx[name] = value
    end
  end
end
