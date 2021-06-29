require 'spec_helper'

describe EvmClient::Function do

  it "calculates id" do
    expect(EvmClient::Function.calc_id("sam(bytes,bool,uint256[])")).to eq "a5643bf27e2786816613d3eeb0b62650200b5a98766dfcfd4428f296fb56d043"
  end

  context "calculates signature without synonyms" do
    let(:inputs_json1) { {"type" => "bytes", "name" => "nomatter"} }
    let(:inputs_json2) { {"type" => "bool", "name" => "nomatter"} }
    let(:inputs_json3) { {"type" => "uint256[]", "name" => "nomatter"} }
    let(:inputs) { [EvmClient::FunctionInput.new(inputs_json1), EvmClient::FunctionInput.new(inputs_json2), EvmClient::FunctionInput.new(inputs_json3)] }
    it "simple" do
      expect(EvmClient::Function.calc_signature("sam", inputs)).to eq "sam(bytes,bool,uint256[])"
    end
  end

  context "calculates signature with synonyms" do
    let(:inputs_json1) { {"type" => "int", "name" => "nomatter"} }
    let(:inputs_json2) { {"type" => "uint[]", "name" => "nomatter"} }
    let(:inputs_json3) { {"type" => "fixed", "name" => "nomatter"} }
    let(:inputs_json4) { {"type" => "ufixed", "name" => "nomatter"} }
    let(:inputs) { [EvmClient::FunctionInput.new(inputs_json1), EvmClient::FunctionInput.new(inputs_json2), EvmClient::FunctionInput.new(inputs_json3), EvmClient::FunctionInput.new(inputs_json4)] }
    it "simple" do
      expect(EvmClient::Function.calc_signature("sam", inputs)).to eq "sam(int256,uint256[],fixed128x128,ufixed128x128)"
    end
  end

end