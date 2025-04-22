# Lispcalc

A Lisp-like calculator interpreter written in Ruby.

Inspired by [Clojure](https://clojure.org/) and my [Casio fx-85GT CW](https://www.casio.co.uk/fx-85gt-cw) calculator, this library provides an interpreter that allows you to perform mathematical calculations using Lisp syntax. It uses Ruby's `BigDecimal` for all calculations, so it supports very accurate floating point numbers.

## Installation

```sh
gem install lispcalc
```

## Usage

This library is intended to be used via the `eval` method.

Here are some examples:

```sh
irb(main):001> require 'lispcalc'
=> true
irb(main):002> Lispcalc.eval('(+ 1 2 3)')
=> 0.6e1
irb(main):003> Lispcalc.eval('(+ 1 2 3)').to_s('F')
=> "6.0"
irb(main):004> Lispcalc.eval('(+ (* 2 3) (/ 2 3))').to_s('F')
=> "6.666666666666666666666666666666666667"
irb(main):005' Lispcalc.eval('
irb(main):006'   (do
irb(main):007'     (>x 100)
irb(main):008'     (>y 200)
irb(main):009'     (*
irb(main):010'       (+ x y)
irb(main):011'       (- x y)
irb(main):012>       (/ x y)))').to_s('F')
=> "-15000.0"
```

## Features

- [x] **Variables**: As in the fx-85GT CW calculator, there are 9 variables available: `A`, `B`, `C`, `D`, `E`, `F`, `x`, `y` and `z`, all of them initialized to `0`. You can set any of these variables to a specific value. For example, `(>A 100)` will set the variable `A` to the value `100`. You can also reference a variable's value like this: `(+ A B)`.
- [x] **Constants**: There are 2 available constants: `pi` and `e`, which hold the values of the corresponding mathematical constants. Unlike variables, you cannot change the value of a constant.
- [x] **Sequencing** (`(do expr1 expr2 ...)`): Evaluate each expression from left to right, returning the final value.
- [x] **Arithmetic operations** (`+`, `-`, `*`, `/`)
- [ ] **Powers, roots and logarithms** (`^`, `^2`, `sqrt`, `log`, `log2`, `log10`, `ln`)
- [ ] **Trigonometric functions** (`sin`, `cos`, `tan`, etc.)
- [ ] **Thread macros** (`->`, `->>`)

## Why?

I created this library for two purposes:

1. Learning more about compilers and interpreters, and how to implement them.
2. Practising my rusty Ruby skills.

## License

This software is released under MIT license.
