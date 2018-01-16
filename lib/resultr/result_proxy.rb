# frozen_string_literal: true

module Resultr
  class ResultProxy
    def initialize(result)
      @result = result
      @resolved = false
    end

    def ok
      resolve_result_if :ok? do |value|
        if block_given?
          yield value
        else
          value
        end
      end
    end

    def err
      resolve_result_if :err? do |reason|
        if block_given?
          yield reason
        else
          reason
        end
      end
    end

    private

    def resolve_result_if(condition)
      if @resolved
        @result.value
      elsif @result.send(condition)
        @resolved = true
        yield @result.value
      end
    end
  end
end
