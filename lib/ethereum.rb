require_relative "ethereum/version"
require 'active_support'
require 'active_support/core_ext'
require 'digest/sha3'
require 'pry'

module Ethereum
  require_relative 'ethereum/abi'
  require_relative 'ethereum/client'
  require_relative 'ethereum/ipc_client'
  require_relative 'ethereum/http_client'
  require_relative 'ethereum/singleton'
  require_relative 'ethereum/solidity'
  require_relative 'ethereum/initializer'
  require_relative 'ethereum/contract'
  require_relative 'ethereum/explorer_url_helper'
  require_relative 'ethereum/function'
  require_relative 'ethereum/function_input'
  require_relative 'ethereum/function_output'
  require_relative 'ethereum/contract_event'
  require_relative 'ethereum/encoder'
  require_relative 'ethereum/decoder'
  require_relative 'ethereum/formatter'
  require_relative 'ethereum/transaction'
  require_relative 'ethereum/deployment'
  require_relative 'ethereum/project_initializer'
  require_relative 'ethereum/contract_initializer'
  require_relative 'ethereum/railtie' if defined?(Rails)
end