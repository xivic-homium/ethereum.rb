module EthereumClient
  class ContractEvent

    attr_accessor :name, :signature, :input_types, :inputs,
                  :event_string, :address, :client,
                  :indexed_inputs, :indexed_outputs,
                  :non_indexed_inputs, :non_indexed_outputs

    def initialize(data)
      @name           = data['name']
      @input_types    = data['inputs'].map {|x| x['type']}
      @inputs         = data['inputs'].map {|x| x['name']}
      @event_string   = "#{@name}(#{@input_types.join(",")})"
      @signature      = Digest::SHA3.hexdigest(@event_string, 256)

      @indexed_inputs     = Array(data['inputs']).select { |input| input['indexed'] == true  }
      @non_indexed_inputs = Array(data['inputs']).select { |input| input['indexed'] == false }

      @indexed_outputs     = Array(data['outputs']).select { |output| output['indexed'] == true  }
      @non_indexed_outputs = Array(data['outputs']).select { |output| output['indexed'] == false }
    end

    def set_address(address)
      @address = address
    end

    def set_client(client)
      @client = client
    end
  end
end

