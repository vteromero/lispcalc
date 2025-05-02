require 'lispcalc'
require 'minitest/autorun'

class TestInterpreter < Minitest::Test
  def test_eval_with_single_list
    interpreter = Lispcalc::Interpreter.new
    assert_equal(3, interpreter.eval([:+, 1.to_d, 2.to_d]))
  end

  def test_eval_with_nested_lists
    interpreter = Lispcalc::Interpreter.new
    assert_equal(
      28,
      interpreter.eval(
        [:+,
         [:*, 2.to_d, 3.to_d],
         [:-, 18.to_d, 4.to_d],
         [:/, 24.to_d, 3.to_d]]
      )
    )
  end

  def test_eval_setting_and_using_variables
    interpreter = Lispcalc::Interpreter.new
    assert_equal(
      100,
      interpreter.eval(
        [:do,
         [:set, :x, 10.to_d],
         [:set, :y, :x],
         [:*, :x, :y]]
      )
    )
  end

  def test_eval_setting_and_using_variables_using_shortcut
    interpreter = Lispcalc::Interpreter.new
    assert_equal(
      110,
      interpreter.eval(
        [:do,
         [:'>x', 10.to_d],
         [:'>y', 11.to_d],
         [:*, :x, :y]]
      )
    )
  end

  def test_eval_list_raises_error_if_argument_is_not_an_array
    interpreter = Lispcalc::Interpreter.new
    error = assert_raises(ArgumentError) do
      interpreter.eval_list(:foo)
    end
    assert_equal 'expecting an instance of Array', error.message
  end

  def test_eval_list_raises_error_if_list_is_empty
    interpreter = Lispcalc::Interpreter.new
    error = assert_raises(Lispcalc::SyntaxError) do
      interpreter.eval_list([])
    end
    assert_equal 'empty list', error.message
  end

  def test_eval_list_raises_error_if_the_first_element_of_a_list_is_not_a_symbol
    interpreter = Lispcalc::Interpreter.new
    error = assert_raises(Lispcalc::SyntaxError) do
      interpreter.eval_list([100.to_d])
    end
    assert_equal 'the first element of a list must be a symbol', error.message
  end

  def test_eval_raises_error_if_form_is_unknown
    interpreter = Lispcalc::Interpreter.new
    assert_raises(Lispcalc::UnknownFormError) do
      interpreter.eval([:+, {}])
    end
  end

  def test_eval_raises_error_if_function_is_undefined
    interpreter = Lispcalc::Interpreter.new
    error = assert_raises(Lispcalc::UnknownFunctionError) do
      interpreter.eval([:foo])
    end
    assert_equal 'undefined function \'foo\'', error.message
  end
end
