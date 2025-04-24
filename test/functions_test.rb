require 'bigdecimal'
require 'bigdecimal/util'
require 'lispcalc'
require 'minitest/autorun'

class TestFunctions < Minitest::Test
  def test_plus
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.+(2.to_d, 3.to_d, 30.to_d, -10.to_d)
    assert_instance_of(BigDecimal, result)
    assert_equal(25.to_d, result)
  end

  def test_plus_with_one_argument
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    error = assert_raises(ArgumentError) do
      functions.+(1.to_d)
    end
    assert_equal('expecting at least 2 arguments, receiving 1', error.message)
  end

  def test_plus_with_argument_that_is_not_bigdecimal
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    error = assert_raises(ArgumentError) do
      functions.+(1.to_d, :foo)
    end
    assert_equal('expecting all arguments to be BigDecimal', error.message)
  end

  def test_minus
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.-(2.to_d, 3.to_d, 30.to_d, -10.to_d)
    assert_instance_of(BigDecimal, result)
    assert_equal(-21.to_d, result)
  end

  def test_minus_with_one_argument
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    error = assert_raises(ArgumentError) do
      functions.-(1.to_d)
    end
    assert_equal('expecting at least 2 arguments, receiving 1', error.message)
  end

  def test_minus_with_argument_that_is_not_bigdecimal
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    error = assert_raises(ArgumentError) do
      functions.-(1.to_d, :foo)
    end
    assert_equal('expecting all arguments to be BigDecimal', error.message)
  end

  def test_multiply
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.*(2.to_d, 3.to_d, -4.to_d, 5.to_d)
    assert_instance_of(BigDecimal, result)
    assert_equal(-120.to_d, result)
  end

  def test_multiply_with_one_argument
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    error = assert_raises(ArgumentError) do
      functions.*(1.to_d)
    end
    assert_equal('expecting at least 2 arguments, receiving 1', error.message)
  end

  def test_multiply_with_argument_that_is_not_bigdecimal
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    error = assert_raises(ArgumentError) do
      functions.*(1.to_d, :foo)
    end
    assert_equal('expecting all arguments to be BigDecimal', error.message)
  end

  def test_divide
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions./(128.to_d, 2.to_d, -4.to_d)
    assert_instance_of(BigDecimal, result)
    assert_equal(-16.to_d, result)
  end

  def test_divide_with_one_argument
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    error = assert_raises(ArgumentError) do
      functions./(1.to_d)
    end
    assert_equal('expecting at least 2 arguments, receiving 1', error.message)
  end

  def test_divide_with_argument_that_is_not_bigdecimal
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    error = assert_raises(ArgumentError) do
      functions./(1.to_d, :foo)
    end
    assert_equal('expecting all arguments to be BigDecimal', error.message)
  end

  def test_power
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    assert_equal 8.to_d, functions.^(2.to_d, 3.to_d)
    assert_equal 2.to_d, functions.^(4.to_d, 0.5.to_d)
    assert_equal 1.to_d, functions.^(2.to_d, 0.to_d)
  end

  def test_power_with_not_bigdecimal_base
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    error = assert_raises(ArgumentError) do
      functions.^(2, 2.to_d)
    end
    assert_equal("expecting 'base' to be BigDecimal", error.message)
  end

  def test_power_with_not_bigdecimal_index
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    error = assert_raises(ArgumentError) do
      functions.^(2.to_d, 2)
    end
    assert_equal("expecting 'index' to be BigDecimal", error.message)
  end

  def test_sqrt
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    assert_equal 5.to_d, functions.sqrt(25.to_d)
  end

  def test_sqrt_with_a_not_bigdecimal_value
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    error = assert_raises(ArgumentError) do
      functions.sqrt(4)
    end
    assert_equal('expecting a BigDecimal', error.message)
  end

  def test_do
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    assert_equal 3, functions.do(1, 2, 3)
  end

  def test_do_with_no_arguments
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    assert_nil functions.do
  end

  def test_set_var
    ctx = Lispcalc::Context.new({ A: 10.to_d })
    functions = Lispcalc::Functions.new(ctx)
    functions.send(:set_var, :A, 20.to_d)
    assert_equal(20.to_d, ctx[:A])
  end

  def test_set_var_with_a_constant_name
    functions = Lispcalc::Functions.new(Lispcalc::Context.new({}, { pi: 3.14.to_d }))
    error = assert_raises(Lispcalc::ContextError) do
      functions.send(:set_var, :pi, 5.5.to_d)
    end
    assert_equal('trying to change the value of the constant \'pi\'', error.message)
  end

  def test_set_var_with_an_undefined_variable
    functions = Lispcalc::Functions.new(Lispcalc::Context.new({ A: 10.to_d }))
    error = assert_raises(Lispcalc::ContextError) do
      functions.send(:set_var, :B, 20.to_d)
    end
    assert_equal('undefined variable \'B\'', error.message)
  end
end
