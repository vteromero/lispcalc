module Lispcalc
  class Context
    def initialize(variables = nil, constants = nil)
      @variables = variables.dup || default_variables
      @constants = constants.dup || default_constants
      @constants.freeze

      unless @variables.values.all?(BigDecimal) && @constants.values.all?(BigDecimal)
        raise ArgumentError, 'variables and constants must be BigDecimal'
      end

      # constant names override variable names
      common_keys = @variables.keys.to_set & @constants.keys.to_set
      common_keys.each do |key|
        @variables.delete(key)
      end
    end

    def [](key)
      @variables[key] || @constants[key]
    end

    def []=(key, value)
      return unless @variables.key?(key) && value.instance_of?(BigDecimal)

      @variables[key] = value
    end

    def var?(name)
      @variables.key?(name)
    end

    def const?(name)
      @constants.key?(name)
    end

    private

    def default_variables
      {
        A: 0.to_d,
        B: 0.to_d,
        C: 0.to_d,
        D: 0.to_d,
        E: 0.to_d,
        F: 0.to_d,
        x: 0.to_d,
        y: 0.to_d,
        z: 0.to_d
      }
    end

    def default_constants
      {
        pi: Math::PI.to_d,
        e: Math::E.to_d
      }
    end
  end
end
