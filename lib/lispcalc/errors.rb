module Lispcalc
  class UnknownTokenError < StandardError; end

  class UnknownFormError < StandardError; end

  class UnknownFunctionError < StandardError; end

  class SyntaxError < StandardError; end

  class ContextError < StandardError; end
end
