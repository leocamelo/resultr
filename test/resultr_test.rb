# frozen_string_literal: true

require 'test_helper'

describe Resultr do
  it 'has a version number' do
    refute_nil Resultr::VERSION
  end

  describe '.ok' do
    it 'returns a success result with given value' do
      result = Resultr.ok('foo')

      assert result.ok?
      assert_equal 'foo', result.value
    end
  end

  describe '.err' do
    it 'results a failed result with given reason' do
      result = Resultr.err('bar')

      assert result.err?
      assert_equal 'bar', result.reason
    end
  end
end
