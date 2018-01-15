# frozen_string_literal: true

require 'test_helper'

describe Resultr::ResultProxy do
  describe '#ok' do
    it 'runs a given block with result value when it has success' do
      result = Resultr.ok('foo')
      result_proxy = Resultr::ResultProxy.new(result)

      result_proxy.ok { |value| assert_equal 'foo', value }
    end

    it 'dont runs a given block when result has failed' do
      result = Resultr.err('foo')
      result_proxy = Resultr::ResultProxy.new(result)

      assert_nil result_proxy.ok { |value| value }
    end
  end

  describe '#err' do
    it 'runs a given block with result reason when it has failed' do
      result = Resultr.err('foo')
      result_proxy = Resultr::ResultProxy.new(result)

      result_proxy.err { |reason| assert_equal 'foo', reason }
    end

    it 'dont runs a given block when result has success' do
      result = Resultr.ok('foo')
      result_proxy = Resultr::ResultProxy.new(result)

      assert_nil result_proxy.err { |reason| reason }
    end
  end
end
