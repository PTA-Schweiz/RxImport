module Rximport
  class MappingError < StandardError
    def initialize(message, error=nil, ref=nil, attribute=nil, mapper=nil)
      @ref = ref
      @attribute = attribute
      @mapper = mapper
      @attribute = attribute
      @inner_error = error
      super message
    end
  end
end