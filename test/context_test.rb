require 'lispcalc'
require 'minitest/autorun'

class TestContext < Minitest::Test
  def test_get_variable
    ctx = Lispcalc::Context.new({ x: 10.to_d, y: 20.to_d })
    assert_equal 10.to_d, ctx[:x]
    assert_equal 20.to_d, ctx[:y]
    assert_nil ctx[:z]
  end

  def test_get_constant
    ctx = Lispcalc::Context.new({}, { pi: 3.14159.to_d })
    assert_equal 3.14159.to_d, ctx[:pi]
    assert_nil ctx[:e]
  end

  def test_update_variable_value
    ctx = Lispcalc::Context.new({ a: 3.to_d })
    assert_equal 3.to_d, ctx[:a]
    ctx[:a] = 5.to_d
    assert_equal 5.to_d, ctx[:a]
  end

  def test_var?
    ctx = Lispcalc::Context.new({ x: 10.to_d })
    assert ctx.var?(:x)
    refute ctx.var?(:y)
  end

  def test_const?
    ctx = Lispcalc::Context.new({}, { pi: 3.14.to_d })
    assert ctx.const?(:pi)
    refute ctx.const?(:e)
  end

  def test_trying_to_set_a_value_for_a_non_existing_variable_does_nothing
    ctx = Lispcalc::Context.new({ a: 3.to_d })
    assert_nil ctx[:b]
    ctx[:b] = 10.to_d
    assert_nil ctx[:b]
  end

  def test_trying_to_set_a_non_bigdecimal_value_does_nothing
    ctx = Lispcalc::Context.new({ a: 2.to_d })
    ctx[:a] = 2000
    assert_equal 2.to_d, ctx[:a]
  end

  def test_trying_to_change_the_value_of_a_constant_does_nothing
    ctx = Lispcalc::Context.new({}, { pi: 3.14159.to_d })
    ctx[:pi] = 3.1.to_d
    assert_equal 3.14159.to_d, ctx[:pi]
  end

  def test_raises_error_if_variable_values_are_not_bigdecimal
    error = assert_raises(ArgumentError) do
      Lispcalc::Context.new({ a: 1.to_d, b: 100 })
    end
    assert_equal 'variables and constants must be BigDecimal', error.message
  end

  def test_raises_error_if_constant_values_are_not_bigdecimal
    error = assert_raises(ArgumentError) do
      Lispcalc::Context.new({}, { pi: 3.1 })
    end
    assert_equal 'variables and constants must be BigDecimal', error.message
  end

  def test_constant_names_override_variable_names
    ctx = Lispcalc::Context.new({ a: 1.to_d }, { a: 100.to_d })
    assert_equal 100.to_d, ctx[:a]
    assert ctx.const?(:a)
    refute ctx.var?(:a)
  end
end
