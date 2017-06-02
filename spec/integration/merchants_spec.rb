require 'spec_helper'

RSpec.describe Starling::Services::MerchantsService do
  let(:client) { Starling::Client.new(access_token: 'dummy_access_token') }
  subject(:service) { client.merchants }

  before { stub_user_agent }

  describe '#get' do
    subject(:merchant) { service.get(id) }

    let(:id) { '4cac93d3-f92a-440d-b4f9-fd5bac8368ba' }

    before do
      stub_request(:get, "https://api.starlingbank.com/api/v1/merchants/#{id}")
        .with(headers: {
                'Accept' => 'application/json',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Authorization' => 'Bearer dummy_access_token',
                'User-Agent' => user_agent
              })
        .to_return(status: status,
                   body: body,
                   headers: headers)
    end

    context 'with a valid ID' do
      let(:status) { 200 }
      let(:body) { load_fixture('merchant.json') }
      let(:headers) { { 'Content-Type' => 'application/json' } }

      it { is_expected.to be_a(Starling::Resources::MerchantResource) }

      it 'correctly constructs a Merchant resource', :aggregate_failures do
        expect(merchant.name).to eq('Aldi')
        expect(merchant.website).to eq('aldi.co.uk')
        expect(merchant.phone_number).to eq('0800 042 0800')
        expect(merchant.twitter_username).to eq('@aldiuk')
      end
    end

    context 'with a non-existent ID' do
      let(:status) { 404 }
      let(:body) { nil }
      let(:headers) { {} }

      it 'raises an error' do
        expect { service.get(id) }.to raise_error(Starling::Errors::ApiError)
      end
    end
  end
end
