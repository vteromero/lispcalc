require 'bigdecimal'
require 'bigdecimal/util'
require 'lispcalc'
require 'minitest/autorun'

class TestFunctions < Minitest::Test
  def test_plus
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.+(2, 3, 30, -10)
    assert_instance_of(BigDecimal, result)
    assert_equal(25, result)
  end

  def test_plus_with_symbol
    ctx = Lispcalc::Context.new({ x: 10.to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.+(5, :x)
    assert_instance_of(BigDecimal, result)
    assert_equal(15, result)
  end

  def test_plus_with_one_argument
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    error = assert_raises(ArgumentError) do
      functions.+(1)
    end
    assert_equal('expecting at least 2 arguments, receiving 1', error.message)
  end

  def test_minus
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.-(2, 3, 30, -10)
    assert_instance_of(BigDecimal, result)
    assert_equal(-21, result)
  end

  def test_minus_with_symbol
    ctx = Lispcalc::Context.new({ x: 10.to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.-(:x, 3)
    assert_instance_of(BigDecimal, result)
    assert_equal(7, result)
  end

  def test_minus_with_one_argument
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    error = assert_raises(ArgumentError) do
      functions.-(1)
    end
    assert_equal('expecting at least 2 arguments, receiving 1', error.message)
  end

  def test_multiply
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.*(2, 3, -4, 5)
    assert_instance_of(BigDecimal, result)
    assert_equal(-120, result)
  end

  def test_multiply_with_symbol
    ctx = Lispcalc::Context.new({ x: 10.to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.*(6, :x)
    assert_instance_of(BigDecimal, result)
    assert_equal(60, result)
  end

  def test_multiply_with_one_argument
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    error = assert_raises(ArgumentError) do
      functions.*(1)
    end
    assert_equal('expecting at least 2 arguments, receiving 1', error.message)
  end

  def test_divide
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions./(128, 2, -4)
    assert_instance_of(BigDecimal, result)
    assert_equal(-16, result)
  end

  def test_divide_with_symbol
    ctx = Lispcalc::Context.new({ x: 10.to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions./(150, :x)
    assert_instance_of(BigDecimal, result)
    assert_equal(15, result)
  end

  def test_divide_with_one_argument
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    error = assert_raises(ArgumentError) do
      functions./(1)
    end
    assert_equal('expecting at least 2 arguments, receiving 1', error.message)
  end

  def test_power_with_index_greater_than_one
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.^(2, 3)
    assert_instance_of(BigDecimal, result)
    assert_equal(8, result)
  end

  def test_power_with_index_less_than_one
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.^(4, 0.5)
    assert_instance_of(BigDecimal, result)
    assert_equal(2, result)
  end

  def test_power_with_index_zero
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.^(2, 0)
    assert_instance_of(BigDecimal, result)
    assert_equal(1, result)
  end

  def test_power_with_symbol
    ctx = Lispcalc::Context.new({ x: 2.to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.^(8, :x)
    assert_instance_of(BigDecimal, result)
    assert_equal(64, result)
  end

  def test_sq
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.sq(12)
    assert_instance_of(BigDecimal, result)
    assert_equal(144, result)
  end

  def test_sq_with_symbol
    ctx = Lispcalc::Context.new({ x: 6.to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.sq(:x)
    assert_instance_of(BigDecimal, result)
    assert_equal(36, result)
  end

  def test_sqrt
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.sqrt(25)
    assert_instance_of(BigDecimal, result)
    assert_equal(5, result)
  end

  def test_sqrt_with_symbol
    ctx = Lispcalc::Context.new({ x: 36.to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.sqrt(:x)
    assert_instance_of(BigDecimal, result)
    assert_equal(6, result)
  end

  def test_cbrt
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.cbrt(27)
    assert_instance_of(BigDecimal, result)
    assert_equal(3, result)
  end

  def test_cbrt_with_symbol
    ctx = Lispcalc::Context.new({ x: 64.to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.cbrt(:x)
    assert_instance_of(BigDecimal, result)
    assert_equal(4, result)
  end

  def test_log
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.log(2.5, 15.625)
    assert_instance_of(BigDecimal, result)
    assert_equal(3, result)
  end

  def test_log_with_symbols
    ctx = Lispcalc::Context.new({ x: 2.to_d, y: 8.to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.log(:x, :y)
    assert_instance_of(BigDecimal, result)
    assert_equal(3, result)
  end

  def test_log10
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.log10(1000)
    assert_instance_of(BigDecimal, result)
    assert_equal(3, result)
  end

  def test_log10_with_symbol
    ctx = Lispcalc::Context.new({ x: 100.to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.log10(:x)
    assert_instance_of(BigDecimal, result)
    assert_equal(2, result)
  end

  def test_log2
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.log2(128)
    assert_instance_of(BigDecimal, result)
    assert_equal(7, result)
  end

  def test_log2_with_symbol
    ctx = Lispcalc::Context.new({ x: 512.to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.log2(:x)
    assert_instance_of(BigDecimal, result)
    assert_equal(9, result)
  end

  def test_ln
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.ln(Math::E**2)
    assert_instance_of(BigDecimal, result)
    assert_equal(2, result)
  end

  def test_ln_with_symbol
    ctx = Lispcalc::Context.new({ x: Math::E.to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.ln(:x)
    assert_instance_of(BigDecimal, result)
    assert_equal(1, result)
  end

  def test_sin
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.sin(Math::PI / 2)
    assert_instance_of(BigDecimal, result)
    assert_equal(1, result)
  end

  def test_sin_with_symbol
    ctx = Lispcalc::Context.new({ x: Math::PI.to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.sin(:x)
    assert_instance_of(BigDecimal, result)
    assert_in_delta(0, result)
  end

  def test_cos
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.cos(0)
    assert_instance_of(BigDecimal, result)
    assert_equal(1.to_d, result)
  end

  def test_cos_with_symbol
    ctx = Lispcalc::Context.new({ x: (Math::PI / 2).to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.cos(:x)
    assert_instance_of(BigDecimal, result)
    assert_in_delta(0, result)
  end

  def test_tan
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.tan(0)
    assert_instance_of(BigDecimal, result)
    assert_equal(0, result)
  end

  def test_tan_with_symbol
    ctx = Lispcalc::Context.new({ x: (Math::PI / 4).to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.tan(:x)
    assert_instance_of(BigDecimal, result)
    assert_in_delta(1, result)
  end

  def test_asin
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.asin(1)
    assert_instance_of(BigDecimal, result)
    assert_equal(Math::PI / 2, result)
  end

  def test_asin_with_symbol
    ctx = Lispcalc::Context.new({ x: -1.to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.asin(:x)
    assert_instance_of(BigDecimal, result)
    assert_equal(- Math::PI / 2, result)
  end

  def test_acos
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.acos(1)
    assert_instance_of(BigDecimal, result)
    assert_equal(0, result)
  end

  def test_acos_with_symbol
    ctx = Lispcalc::Context.new({ x: -1.to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.acos(:x)
    assert_instance_of(BigDecimal, result)
    assert_equal(Math::PI, result)
  end

  def test_atan
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.atan(0)
    assert_instance_of(BigDecimal, result)
    assert_equal(0, result)
  end

  def test_atan_with_symbol
    ctx = Lispcalc::Context.new({ x: 1.to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.atan(:x)
    assert_instance_of(BigDecimal, result)
    assert_equal(Math::PI / 4, result)
  end

  def test_do
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    result = functions.do(1, 2, 3)
    assert_instance_of(BigDecimal, result)
    assert_equal(3, result)
  end

  def test_do_with_symbols
    ctx = Lispcalc::Context.new({ x: 1.to_d, y: 2.to_d, z: 3.to_d })
    functions = Lispcalc::Functions.new(ctx)
    result = functions.do(:x, :y, :z)
    assert_instance_of(BigDecimal, result)
    assert_equal(3, result)
  end

  def test_do_with_no_arguments
    functions = Lispcalc::Functions.new(Lispcalc::Context.new)
    assert_nil functions.do
  end

  def test_set
    ctx = Lispcalc::Context.new({ A: 10.to_d })
    functions = Lispcalc::Functions.new(ctx)
    functions.set(:A, 20)
    assert_instance_of(BigDecimal, ctx[:A])
    assert_equal(20, ctx[:A])
  end

  def test_set_with_symbol
    ctx = Lispcalc::Context.new({ x: 10.to_d, y: 20.to_d })
    functions = Lispcalc::Functions.new(ctx)
    functions.set(:x, :y)
    assert_instance_of(BigDecimal, ctx[:x])
    assert_equal(20, ctx[:x])
  end

  def test_set_with_a_constant_name
    functions = Lispcalc::Functions.new(Lispcalc::Context.new({}, { pi: 3.14.to_d }))
    error = assert_raises(Lispcalc::ContextError) do
      functions.set(:pi, 5.5)
    end
    assert_equal('trying to change the value of the constant \'pi\'', error.message)
  end

  def test_set_with_an_undefined_variable
    functions = Lispcalc::Functions.new(Lispcalc::Context.new({ A: 10.to_d }))
    error = assert_raises(Lispcalc::ContextError) do
      functions.set(:B, 20)
    end
    assert_equal('undefined variable \'B\'', error.message)
  end
end
