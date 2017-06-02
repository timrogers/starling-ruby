require 'spec_helper'

RSpec.describe Starling::Resources::MerchantResource do
  subject(:merchant) { described_class.new(response: response) }
  let(:fixture) { load_fixture('merchant.json') }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:merchant_uid) { is_expected.to eq('4cac93d3-f92a-440d-b4f9-fd5bac8368ba') }
  its(:name) { is_expected.to eq('Aldi') }
  its(:website) { is_expected.to eq('aldi.co.uk') }
  its(:phone_number) { is_expected.to eq('0800 042 0800') }
  its(:twitter_username) { is_expected.to eq('@aldiuk') }
end
