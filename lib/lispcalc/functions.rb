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

    def ^(base, index)
      base**index
    end

    def sqrt(x)
      Math.sqrt(x).to_d
    end

    def log(base, x)
      Math.log(x, base).to_d
    end

    def log10(x)
      Math.log10(x).to_d
    end

    def log2(x)
      Math.log2(x).to_d
    end

    def ln(x)
      log(Math::E, x)
    end

    def sin(x)
      Math.sin(x).to_d
    end

    def cos(x)
      Math.cos(x).to_d
    end

    def tan(x)
      Math.tan(x).to_d
    end

    def asin(x)
      Math.asin(x).to_d
    end

    def acos(x)
      Math.acos(x).to_d
    end

    def atan(x)
      Math.atan(x).to_d
    end

    def do(*args)
      args.last unless args.empty?
    end

    private

    def arithmetic_op(op, args)
      raise ArgumentError, "expecting at least 2 arguments, receiving #{args.size}" unless args.size >= 2

      args.inject(op)
    end

    def set_var(name, value)
      raise ContextError, "trying to change the value of the constant '#{name}'" if @ctx.const?(name)
      raise ContextError, "undefined variable '#{name}'" unless @ctx.var?(name)

      @ctx[name] = value
    end
  end
end
