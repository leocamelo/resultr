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
      @kind === :ok
    end

    def err?
      @kind === :err
    end

    def expect!(message)
      if ok?
        value
      elsif err?
        raise message
      end
    end

    def then(&block)
      result_proxy = Resultr::ResultProxy.new(self)
      result_proxy.instance_eval(&block)
    end
  end
end
