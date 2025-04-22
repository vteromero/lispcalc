require 'lispcalc'
require 'minitest/autorun'

class TestLexer < Minitest::Test
  def test_tokenize_with_empty_string
    assert Lispcalc::Lexer.tokenize('').empty?
  end

  def test_tokenize_with_whitespaces_only
    assert Lispcalc::Lexer.tokenize('         ').empty?
  end

  def test_tokenize_with_parens_and_whitespaces
    assert_equal(
      [
        [:open_paren],
        [:open_paren],
        [:close_paren],
        [:open_paren],
        [:close_paren],
        [:close_paren]
      ],
      Lispcalc::Lexer.tokenize(' ((  ) () )  ')
    )
  end

  def test_tokenize_with_symbols
    assert_equal(
      [
        [:symbol, 'aa8b'],
        [:symbol, 'h123h']
      ],
      Lispcalc::Lexer.tokenize(' aa8b h123h')
    )
  end

  def test_tokenize_with_numbers
    assert_equal(
      [
        [:number, '150999'],
        [:number, '-78.333'],
        [:number, '0.0001']
      ],
      Lispcalc::Lexer.tokenize('150999 -78.333 0.0001')
    )
  end

  def test_tokenize_with_all_tokens
    assert_equal(
      [
        [:open_paren],
        [:symbol, 'a'],
        [:number, '15'],
        [:symbol, 'b'],
        [:open_paren],
        [:symbol, 'x'],
        [:number, '-1.2'],
        [:close_paren],
        [:open_paren],
        [:symbol, 'p'],
        [:symbol, 'q'],
        [:close_paren],
        [:close_paren]
      ],
      Lispcalc::Lexer.tokenize('(a 15 b (x -1.2) (p q))')
    )
  end

  def test_tokenize_raises_unknown_token_error
    assert_raises(Lispcalc::UnknownTokenError) do
      Lispcalc::Lexer.tokenize('$ ()')
    end
  end
end
