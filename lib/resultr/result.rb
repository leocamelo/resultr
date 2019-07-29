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

    def and_then
      if ok?
        yield @value
      else
        self
      end
    end

    def or_else
      if err?
        yield @value
      else
        self
      end
    end

    def expect!(message = nil)
      return @value if ok?

      raise ::Resultr::ExpectationError, message || @value
    end

    def thus
      result_proxy = ::Resultr::ResultProxy.new(self)
      yield result_proxy
    end
  end
end
