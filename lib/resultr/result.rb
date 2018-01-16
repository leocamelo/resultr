# frozen_string_literal: true

module Resultr
  class Result
    attr_reader :value
    alias reason value

    def initialize(kind, value)
      @kind = kind
      @value = value
    end

    def ok?
      @kind == :ok
    end

    def err?
      @kind == :err
    end

    def expect!(message)
      if ok?
        value
      elsif err?
        raise ::Resultr::ExpectationError, message
      end
    end

    def thus
      if block_given?
        result_proxy = ::Resultr::ResultProxy.new(self)
        yield result_proxy
      end
    end
  end
end
