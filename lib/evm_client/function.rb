module EvmClient
  class Function

    attr_accessor :name, :inputs, :outputs, :signature, :minified_signature, :constant, :function_string

    def initialize(data)
      @name     = data["name"]
      @constant = data["constant"]

      @inputs   = data["inputs"].map do |input|
        EvmClient::FunctionInput.new(input)
      end

      @outputs = data["outputs"].collect do |output|
        EvmClient::FunctionOutput.new(output)
      end

      @function_string    = self.class.calc_signature(@name, @inputs)
      @signature          = self.class.calc_id(@function_string)
      @minified_signature = signature[0..7]
    end

    def self.to_canonical_type(type)
      type
      .gsub(/(int)(\z|\D)/, '\1256\2')
      .gsub(/(uint)(\z|\D)/, '\1256\2')
      .gsub(/(fixed)(\z|\D)/, '\1128x128\2')
      .gsub(/(ufixed)(\z|\D)/, '\1128x128\2')
    end

    def self.calc_signature(name, inputs)
      "#{name}(#{inputs.collect {|x| self.to_canonical_type(x.type) }.join(",")})"
    end

    def self.calc_id(signature)
      Digest::SHA3.hexdigest(signature, 256)
    end

  end
end
