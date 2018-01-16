# frozen_string_literal: true

require 'test_helper'

describe Resultr::Result do
  describe '#ok?' do
    it 'returns if the result has success' do
      success_result = Resultr::Result.new(:ok, nil)
      failed_result = Resultr::Result.new(:err, nil)

      assert success_result.ok?
      refute failed_result.ok?
    end
  end

  describe '#err?' do
    it 'returns if the result has failed' do
      success_result = Resultr::Result.new(:ok, nil)
      failed_result = Resultr::Result.new(:err, nil)

      refute success_result.err?
      assert failed_result.err?
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
