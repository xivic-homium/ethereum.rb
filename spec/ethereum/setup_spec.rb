require 'tempfile'
require 'spec_helper'

describe 'EvmClient::Singleton.instance' do

    before(:each) do
      EvmClient::Singleton.reset
    end

    it 'should setup to IpcClient' do
      EvmClient::Singleton.setup do |c|
        c.client = :ipc        
        c.ipcpath = "/tmp/some.ipc"
        c.log = true
      end
      instance = EvmClient::Singleton.instance
      expect(instance).to be_an_instance_of(EvmClient::IpcClient)
      expect(instance.ipcpath).to eq "/tmp/some.ipc"
      expect(instance.log).to be true
    end

    it 'should setup to HttpClient' do
      EvmClient::Singleton.setup do |c|
        c.client = :http
        c.host = "http://121.1.1.1:80"
        c.log = false
      end
      instance = EvmClient::Singleton.instance
      expect(instance).to be_an_instance_of(EvmClient::HttpClient)
      expect(instance.host).to eq "121.1.1.1"
      expect(instance.port).to eq 80
      expect(instance.log).to be false
    end
    
    it 'should setup default account' do
      EvmClient::Singleton.setup { |c| c.default_account = "0x1234567890123456789012345678901234567890" }
      expect(EvmClient::Singleton.instance.default_account).to eq "0x1234567890123456789012345678901234567890"
    end

    it 'should pick first account as default account if no account specifed' do
      expect(EvmClient::Singleton.instance.default_account).to eq EvmClient::Singleton.instance.eth_accounts["result"][0]
    end
    
    it 'should be IpcCLient by default' do
      instance = EvmClient::Singleton.instance
      expect(instance).to be_an_instance_of(EvmClient::IpcClient)
    end

end