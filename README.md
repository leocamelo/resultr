# Resultr

[![Build Status](https://travis-ci.org/leocamelo/resultr.svg?branch=master)](https://travis-ci.org/leocamelo/resultr)
[![Maintainability](https://api.codeclimate.com/v1/badges/d59916bca76b37153273/maintainability)](https://codeclimate.com/github/leocamelo/resultr/maintainability)

Ruby beautiful results.

Resultr provides a simple interface to work with computing results, highly
inspired by [Rust results](https://doc.rust-lang.org/std/result) for handling
errors on function returns.

## Installation

Add Resultr to your `Gemfile`:

```ruby
gem 'resultr'
```

and run `bundle install` from your shell.

To install the gem manually from your shell, run:

```shell
$ gem install resultr
```

## Getting Started

### Good and bad results

Resultr works with two kinds of results, good results (ok)
and bad results (err). You can store any kind of data on any kind of result.

```ruby
  good_result = Resultr.ok(42)
  # => <Resultr::Result @kind=:ok @value=42>

  good_result.ok?
  # => true

  good_result.value
  # => 42

  bad_result = Resultr.err('foo')
  # => <Resultr::Result @kind=:err @value="foo">

  bad_result.err?
  # => true

  bad_result.reason
  # => "foo"
```

*`Result#reason` is an alias of `Result#value`, but is a common
practice to use `value` for good results and `reason` for bad results.*

## License

Resultr is freely distributable under the
[MIT license](https://github.com/leocamelo/minitooltip/blob/master/LICENSE)

## Author

[@leocamelo](https://twitter.com/@leocamelo)
