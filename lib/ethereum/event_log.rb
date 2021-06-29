module Ethereum
  class EventLog
    attr_reader :address, :block_hash, :block_number, :data, :log_index, :removed,
    :topics, :transaction_hash, :transaction_index, :signature, :contract, :event

    def self.build(raw_response:, contract:)
      signature = raw_response['topics'][0]
      event     = contract.events.find { |event| signature.match(event.signature) }

      new(
        address:           raw_response['address'],
        block_hash:        raw_response['blockHash'],
        block_number:      raw_response['blockNumber'].to_i(16),
        data:              raw_response['data'],
        log_index:         raw_response['logIndex'],
        removed:           raw_response['removed'],
        topics:            raw_response['topics'],
        transaction_hash:  raw_response['transactionHash'],
        transaction_index: raw_response['transactionIndex'],
        signature:         signature,
        contract:          contract,
        event:             event
      )
    end

    def initialize( address:, block_hash:, block_number:, data:, log_index:, removed:,
                    topics:, transaction_hash:, transaction_index:, signature:, contract:, event:)
      @address            = address
      @block_hash         = block_hash
      @block_number       = block_number
      @data               = data
      @log_index          = log_index
      @removed            = removed
      @topics             = topics
      @transaction_hash   = transaction_hash
      @transaction_index  = transaction_index
      @signature          = signature
      @contract           = contract
      @event              = event
    end

    def name
      event.name
    end

    def return_values
      return_values = {}

      indexed_params.each_with_index do |param, index|
        return_values[param.name] = topics[index+1]
      end

      non_indexed_params.each_with_index do |param, index|
        return_values[param.name]  = Decoder.new.decode_arguments(non_indexed_params, data)[index]
      end

      return_values
    end

    def to_h
      {
        address:            address,
        block_hash:         block_hash,
        block_number:       block_number,
        data:               data,
        log_index:          log_index,
        removed:            removed,
        topics:             topics,
        transaction_hash:   transaction_hash,
        transaction_index:  transaction_index,
        signature:          signature,
        name:               name,
        contract_name:      contract.name,
        return_values:      return_values
      }
    end

    private

    def indexed_params
      [event.indexed_inputs, event.indexed_outputs].flatten.map { |input| OpenStruct.new(input) }
    end

    def non_indexed_params
      [event.non_indexed_inputs, event.non_indexed_outputs].flatten.map { |output| OpenStruct.new(output) }
    end
  end
end
