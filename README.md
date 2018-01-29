# Resultr

[![Build Status](https://travis-ci.org/leocamelo/resultr.svg?branch=master)](https://travis-ci.org/leocamelo/resultr)
[![Maintainability](https://api.codeclimate.com/v1/badges/d59916bca76b37153273/maintainability)](https://codeclimate.com/github/leocamelo/resultr/maintainability)

Ruby beautiful results.

Resultr provides a simple interface to work with computation results, highly
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

Resultr works with two kinds of results, good results (`Resultr.ok`) and bad
results (`Resultr.err`). You can store any kind of data on any kind of result.

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

### Chaining of results

You can chain results with `Result#and_then` and `Result#or_else` methods,
both will receive a block using result's value / reason and returns the
block return or itself, depending on result kind.

```ruby
  def shout(word)
    if word == 'marco'
      Resultr.ok('polo')
    else
      Resultr.err('unknown word')
    end
  end

  # =========================================
  # Using #and_then to chaining good results.
  # =========================================

  shout('marco').and_then { |value| "#{value}!" }
  # => "polo!"

  shout('foo').and_then { |value| "#{value}!" }
  # => <Resultr::Result @kind=:err @value="unknown word">

  # =======================================
  # Using #or_else to chaining bad results.
  # =======================================

  shout('marco').or_else { |reason| "#{reason}, try 'marco'" }
  # => <Resultr::Result @kind=:ok @value="polo">

  shout('foo').or_else { |reason| "#{reason}, try 'marco'" }
  # => "unknown word, try 'marco'"

  # ================================================
  # Using both to chaining the two kinds of results.
  # ================================================

  shout('marco').and_then { |v| "#{v}!" }.or_else { |r| "#{r}, try 'marco'" }
  # => "polo!"

  shout('foo').and_then { |v| "#{v}!" }.or_else { |r| "#{r}, try 'marco'" }
  # => "unknown word, try 'marco'"
```

### Elegant result branching

Resultr provides a sugar syntax for branching results by kind,
its called `Result#thus` and works like a flavor of case statement.

```ruby
  def list_posts
    response = get('/posts')

    if response.status == 200
      Resultr.ok(response.body)
    else
      Resultr.err(response.body)
    end
  end

  # ==================================
  # Using #thus for branching actions.
  # ==================================

  list_posts.thus do |result|
    result.ok |value|
      render json: { posts: value }
    end
    result.err do |reason|
      render json: { error: reason }
    end
  end

  # =====================================
  # Using #thus for branching assignment.
  # =====================================

  posts = list_posts.thus do |result|
    result.ok { |value| value }
    result.err { |_reason| [] }
  end
```

## License

Resultr is freely distributable under the
[MIT license](https://github.com/leocamelo/minitooltip/blob/master/LICENSE)
