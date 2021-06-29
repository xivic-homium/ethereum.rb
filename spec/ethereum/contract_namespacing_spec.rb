require 'spec_helper'

describe EvmClient::Contract do

  let(:client) { EvmClient::IpcClient.new }
  let(:path) { "#{Dir.pwd}/spec/fixtures/TestContract.sol" }

  it "namespaces the generated contract class" do
    @works = EvmClient::Contract.create(file: path, client: client)
    expect(@works.parent.class_object.to_s).to eq("EvmClient::Contract::TestContract")
  end

end
