require 'spec_helper'

describe EvmClient do

  let(:client) { EvmClient::IpcClient.new }
  let(:path) { "#{Dir.pwd}/spec/fixtures/TestContract.sol" }

  it "builds, deploys, call methods, receives events and kills contract", blockchain: true do
    @works = EvmClient::Contract.create(file: path, client: client)
    expect(@works.estimate("The title")).to be > 100
    contract_address = @works.deploy_and_wait("The title")

    filter_id = @works.new_filter.changed address: contract_address, topics: []
    tx_address = @works.transact_and_wait.set("some4key", "somethevalue").address
    expect(EvmClient::Transaction.from_blockchain(tx_address).mined?).to be true

    expect(@works.get_filter_logs.changed(filter_id)[0][:transactionHash]).to eq tx_address

    @works_reloaded = EvmClient::Contract.create(name: "WorksReloaded", address: contract_address, abi: @works.abi, client: client)
    expect(@works_reloaded.call.get("some4key")).to eq ["somethevalue", "żółć"]
    expect(@works.transact_and_wait.kill.mined?).to be true
  end

end
