# frozen_string_literal: true

module Resultr
  class ResultProxy
    def initialize(result)
      @result = result
      @resolved = false
      @resolved_value = nil
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
        @resolved_value
      elsif @result.send(condition)
        @resolved = true
        @resolved_value = yield @result.value
      end
    end
  end
end
