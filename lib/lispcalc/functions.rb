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
      resolve_symbol(base).to_d ** resolve_symbol(index).to_d
    end

    def sqrt(x)
      Math.sqrt(resolve_symbol(x)).to_d
    end

    def cbrt(x)
      Math.cbrt(resolve_symbol(x)).to_d
    end

    def log(base, x)
      Math.log(resolve_symbol(x), resolve_symbol(base)).to_d
    end

    def log10(x)
      Math.log10(resolve_symbol(x)).to_d
    end

    def log2(x)
      Math.log2(resolve_symbol(x)).to_d
    end

    def ln(x)
      log(Math::E, x)
    end

    def sin(x)
      Math.sin(resolve_symbol(x)).to_d
    end

    def cos(x)
      Math.cos(resolve_symbol(x)).to_d
    end

    def tan(x)
      Math.tan(resolve_symbol(x)).to_d
    end

    def asin(x)
      Math.asin(resolve_symbol(x)).to_d
    end

    def acos(x)
      Math.acos(resolve_symbol(x)).to_d
    end

    def atan(x)
      Math.atan(resolve_symbol(x)).to_d
    end

    def do(*args)
      resolve_symbol(args.last).to_d unless args.empty?
    end

    def set(name, value)
      raise ContextError, "trying to change the value of the constant '#{name}'" if @ctx.const?(name)
      raise ContextError, "undefined variable '#{name}'" unless @ctx.var?(name)

      @ctx[name] = resolve_symbol(value).to_d
    end

    private

    # TODO: raise exception if symbol is not found in context
    def resolve_symbol(x)
      if x.instance_of?(Symbol)
        @ctx[x]
      else
        x
      end
    end

    def arithmetic_op(op, args)
      raise ArgumentError, "expecting at least 2 arguments, receiving #{args.size}" unless args.size >= 2

      args.map { |x| resolve_symbol(x).to_d }.inject(op)
    end
  end
end
