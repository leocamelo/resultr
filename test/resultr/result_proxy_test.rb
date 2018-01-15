# frozen_string_literal: true

require 'test_helper'

describe Resultr::ResultProxy do
  describe '#ok' do
    it 'runs a given block with result value when it has success' do
      result = Resultr.ok('foo')
      result_proxy = Resultr::ResultProxy.new(result)

      result_proxy.ok { |value| assert_equal 'foo', value }
    end

    it 'returns the result value when it has success and dont given a block' do
      result = Resultr.ok('foo')
      result_proxy = Resultr::ResultProxy.new(result)

      assert_equal 'foo', result_proxy.ok
    end

    it 'dont runs a given block when result has failed' do
      result = Resultr.err('foo')
      result_proxy = Resultr::ResultProxy.new(result)

      assert_nil result_proxy.ok { |value| value }
    end

    it 'returns the result reason when it has failed and using as chain' do
      result = Resultr.err('foo')
      result_proxy = Resultr::ResultProxy.new(result)

      result_proxy.err
      assert_equal 'foo', result_proxy.ok
    end
  end

  describe '#err' do
    it 'runs a given block with result reason when it has failed' do
      result = Resultr.err('foo')
      result_proxy = Resultr::ResultProxy.new(result)

      result_proxy.err { |reason| assert_equal 'foo', reason }
    end

    it 'returns the result rason when it has failed and dont given a block' do
      result = Resultr.err('foo')
      result_proxy = Resultr::ResultProxy.new(result)

      assert_equal 'foo', result_proxy.err
    end

    it 'dont runs a given block when result has success' do
      result = Resultr.ok('foo')
      result_proxy = Resultr::ResultProxy.new(result)

      assert_nil result_proxy.err { |reason| reason }
    end

    it 'returns the result value when it has success and using as chain' do
      result = Resultr.ok('foo')
      result_proxy = Resultr::ResultProxy.new(result)

      result_proxy.ok
      assert_equal 'foo', result_proxy.err
    end
  end
end
