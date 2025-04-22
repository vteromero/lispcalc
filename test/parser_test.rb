require 'lispcalc'
require 'minitest/autorun'

class TestParser < Minitest::Test
  def test_parse_with_empty_tokens
    assert_nil Lispcalc::Parser.new([]).parse
  end

  def test_raises_error_if_given_tokens_is_not_an_array
    error = assert_raises(ArgumentError) do
      Lispcalc::Parser.new({})
    end
    assert_equal 'expecting an Array', error.message
  end

  def test_invalid_token1
    error = assert_raises(ArgumentError) do
      Lispcalc::Parser.new([{}])
    end
    assert_equal 'invalid token', error.message
  end

  def test_invalid_token2
    error = assert_raises(ArgumentError) do
      Lispcalc::Parser.new([['foo']])
    end
    assert_equal 'invalid token', error.message
  end

  def test_invalid_token3
    error = assert_raises(ArgumentError) do
      Lispcalc::Parser.new([[:a, 123]])
    end
    assert_equal 'invalid token', error.message
  end

  def test_parse_with_no_top_level_list
    error = assert_raises(Lispcalc::SyntaxError) do
      Lispcalc::Parser.new([
        [:symbol, 'a'],
        [:symbol, 'b'],
        [:close_paren]
      ]).parse
    end
    assert_equal "expecting '('", error.message
  end

  def test_parse_with_more_than_a_single_top_level_list
    error = assert_raises(Lispcalc::SyntaxError) do
      Lispcalc::Parser.new([
        [:open_paren],
        [:symbol, 'a'],
        [:close_paren],
        [:open_paren],
        [:symbol, 'b'],
        [:close_paren]
      ]).parse
    end
    assert_equal 'expecting a single top-level list', error.message
  end

  def test_parse_with_unclosed_list
    error = assert_raises(Lispcalc::SyntaxError) do
      Lispcalc::Parser.new([
        [:open_paren],
        [:symbol, 'a'],
        [:symbol, 'b'],
        [:symbol, 'c']
      ]).parse
    end
    assert_equal "unclosed list; expecting ')'", error.message
  end

  def test_parse_with_nested_unclosed_list
    error = assert_raises(Lispcalc::SyntaxError) do
      Lispcalc::Parser.new([
        [:open_paren],
        [:symbol, 'a'],
        [:symbol, 'b'],
        [:open_paren],
        [:symbol, 'x'],
        [:symbol, 'y'],
        [:close_paren],
        [:open_paren],
        [:symbol, 'p'],
        [:symbol, 'q'],
        [:close_paren]
      ]).parse
    end
    assert_equal "unclosed list; expecting ')'", error.message
  end

  def test_parse_with_nested_unclosed_list_v2
    error = assert_raises(Lispcalc::SyntaxError) do
      Lispcalc::Parser.new([
        [:open_paren],
        [:symbol, 'a'],
        [:symbol, 'b'],
        [:open_paren],
        [:symbol, 'x'],
        [:symbol, 'y'],
        [:open_paren],
        [:symbol, 'p'],
        [:symbol, 'q']
      ]).parse
    end
    assert_equal "unclosed list; expecting ')'", error.message
  end

  def test_parse_with_unknown_token
    assert_raises(Lispcalc::UnknownTokenError) do
      Lispcalc::Parser.new([
        [:open_paren],
        [:foo],
        [:close_paren]
      ]).parse
    end
  end

  def test_parse_numbers
    assert_equal(
      [
        BigDecimal('222500'),
        BigDecimal('-7.000000019'),
        BigDecimal('+33.66')
      ],
      Lispcalc::Parser.new([
        [:open_paren],
        [:number, '222500'],
        [:number, '-7.000000019'],
        [:number, '+33.66'],
        [:close_paren]
      ]).parse
    )
  end

  def test_parse_single_list
    assert_equal(
      [:a, :b, :c],
      Lispcalc::Parser.new([
        [:open_paren],
        [:symbol, 'a'],
        [:symbol, 'b'],
        [:symbol, 'c'],
        [:close_paren]
      ]).parse
    )
  end

  def test_parse_nested_lists
    assert_equal(
      [
        :a,
        200.to_d,
        100.to_d,
        [:x, :y],
        [:p, :q, :r]
      ],
      Lispcalc::Parser.new([
        [:open_paren],
        [:symbol, 'a'],
        [:number, '200'],
        [:number, '100'],
        [:open_paren],
        [:symbol, 'x'],
        [:symbol, 'y'],
        [:close_paren],
        [:open_paren],
        [:symbol, 'p'],
        [:symbol, 'q'],
        [:symbol, 'r'],
        [:close_paren],
        [:close_paren]
      ]).parse
    )
  end
end
