require_relative 'evm_client/version'
require 'active_support'
require 'active_support/core_ext'
require 'digest/sha3'
require 'pry'

module EvmClient
  ruby_project_files = Dir[File.join(File.dirname(__FILE__), '**', '*.rb')]

  ruby_project_files.sort_by!{ |file_name| file_name.downcase }.each do |path|
    require_relative path unless path.match?(/rail/)
  end

  require_relative 'evm_client/railtie' if defined?(Rails)
end
