require 'tempfile'
require 'spec_helper'

describe 'EthereumClient::Singleton.instance' do

    before(:each) do
      EthereumClient::Singleton.reset
    end

    it 'should setup to IpcClient' do
      EthereumClient::Singleton.setup do |c|
        c.client = :ipc        
        c.ipcpath = "/tmp/some.ipc"
        c.log = true
      end
      instance = EthereumClient::Singleton.instance
      expect(instance).to be_an_instance_of(EthereumClient::IpcClient)
      expect(instance.ipcpath).to eq "/tmp/some.ipc"
      expect(instance.log).to be true
    end

    it 'should setup to HttpClient' do
      EthereumClient::Singleton.setup do |c|
        c.client = :http
        c.host = "http://121.1.1.1:80"
        c.log = false
      end
      instance = EthereumClient::Singleton.instance
      expect(instance).to be_an_instance_of(EthereumClient::HttpClient)
      expect(instance.host).to eq "121.1.1.1"
      expect(instance.port).to eq 80
      expect(instance.log).to be false
    end
    
    it 'should setup default account' do
      EthereumClient::Singleton.setup { |c| c.default_account = "0x1234567890123456789012345678901234567890" }
      expect(EthereumClient::Singleton.instance.default_account).to eq "0x1234567890123456789012345678901234567890"
    end

    it 'should pick first account as default account if no account specifed' do
      expect(EthereumClient::Singleton.instance.default_account).to eq EthereumClient::Singleton.instance.eth_accounts["result"][0]
    end
    
    it 'should be IpcCLient by default' do
      instance = EthereumClient::Singleton.instance
      expect(instance).to be_an_instance_of(EthereumClient::IpcClient)
    end

end