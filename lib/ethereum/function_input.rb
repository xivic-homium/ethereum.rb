module Ethereum
  class FunctionInput

    attr_accessor :type, :name, :indexed

    def initialize(data)
      @type    = data["type"]
      @name    = data["name"]
      @indexed = data["index"]
    end

  end

end
