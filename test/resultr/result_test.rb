# frozen_string_literal: true

require 'test_helper'

describe Resultr::Result do
  describe '#ok?' do
    it 'returns if the result has success' do
      good_result = Resultr::Result.new(:ok, nil)
      bad_result = Resultr::Result.new(:err, nil)

      assert good_result.ok?
      refute bad_result.ok?
    end
  end

  describe '#err?' do
    it 'returns if the result has failed' do
      good_result = Resultr::Result.new(:ok, nil)
      bad_result = Resultr::Result.new(:err, nil)

      refute good_result.err?
      assert bad_result.err?
    end
  end

  describe '#and_then' do
    it 'runs a given block with result value when it has success' do
      result = Resultr::Result.new(:ok, 1)
      new_result = result.and_then { |value| value + 1 }

      assert_equal 2, new_result
    end

    it 'dont runs a given block and return self when result has failed' do
      result = Resultr::Result.new(:err, 1)
      new_result = result.and_then { |value| value + 1 }

      assert_equal result, new_result
    end
  end

  describe '#or_else' do
    it 'runs a given block with result reason when it has failed' do
      result = Resultr::Result.new(:err, 1)
      new_result = result.or_else { |reason| reason + 1 }

      assert_equal 2, new_result
    end

    it 'dont runs a given block and return self when result has success' do
      result = Resultr::Result.new(:ok, 1)
      new_result = result.or_else { |reason| reason + 1 }

      assert_equal result, new_result
    end
  end

  describe '#expect!' do
    it 'returns the given value when the result has success' do
      result = Resultr::Result.new(:ok, 'foo')

      assert_equal 'foo', result.expect!('bar')
    end

    it 'raises an exception when the result has failed' do
      result = Resultr::Result.new(:err, 'foo')

      error = assert_raises Resultr::ExpectationError do
        result.expect!('bar')
      end

      assert_equal 'bar', error.message
    end
  end

  describe '#thus' do
    it 'runs a given block in a ResultProxy context' do
      result = Resultr::Result.new(:ok, nil)

      result.thus do |result_proxy|
        assert_instance_of Resultr::ResultProxy, result_proxy
      end
    end
  end
end
