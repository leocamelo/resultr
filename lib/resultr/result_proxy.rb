# frozen_string_literal: true

module Resultr
  class ResultProxy
    def initialize(result)
      @result = result
      @resolved = false
    end

    def ok
      if @resolved
        @result.value
      elsif @result.ok?
        @resolved = true

        if block_given?
          yield(@result.value)
        else
          @result.value
        end
      end
    end

    def err
      if @resolved
        @result.reason
      elsif @result.err?
        @resolved = true

        if block_given?
          yield(@result.reason)
        else
          @result.reason
        end
      end
    end
  end
end
