module Resultr
  class ResultProxy
    def initialize(result)
      @result = result
    end

    def ok
      yield(@result.value) if @result.ok?
    end

    def err
      yield(@result.reason) if @result.err?
    end
  end
end
