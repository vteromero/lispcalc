require 'lispcalc'
require 'minitest/autorun'

class TestEval < Minitest::Test
  def test_eval_with_single_list
    assert_equal 3, Lispcalc.eval('(+ 1 2)')
  end

  def test_eval_with_nested_lists
    assert_equal 28, Lispcalc.eval('(+ (* 2 3) (- 18 4) (/ 24 3))')
  end

  def test_set_and_use_variables
    assert_equal 110, Lispcalc.eval('(do (>x 10) (>y 11) (* x y))')
  end

  def test_powers
    assert_equal 7.to_d, Lispcalc.eval('(+ (^ 2 2) (^ 2 1) (^ 2 0))')
  end

  def test_logs
    assert_equal 12.to_d, Lispcalc.eval('(+ (log10 100) (log2 32) (ln (^ e 5)))')
  end
end
