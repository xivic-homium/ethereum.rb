require 'spec_helper'

describe EthereumClient::Contract do

  let(:client) { EthereumClient::IpcClient.new }
  let(:path) { "#{Dir.pwd}/spec/fixtures/TestContract.sol" }

  it "namespaces the generated contract class" do
    @works = EthereumClient::Contract.create(file: path, client: client)
    expect(@works.parent.class_object.to_s).to eq("EthereumClient::Contract::TestContract")
  end

end
