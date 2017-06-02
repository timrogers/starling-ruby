require 'spec_helper'

RSpec.describe Starling::Services::AddressesService do
  let(:client) { Starling::Client.new(access_token: 'dummy_access_token') }
  subject(:service) { client.addresses }

  before { stub_user_agent }

  describe '#get' do
    subject(:addresses) { service.get }

    let(:fixture) { load_fixture('addresses.json') }

    before do
      stub_request(:get, 'https://api.starlingbank.com/api/v1/addresses')
        .with(headers: {
                'Accept' => 'application/json',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Authorization' => 'Bearer dummy_access_token',
                'User-Agent' => user_agent
              })
        .to_return(status: 200,
                   body: fixture,
                   headers: { 'Content-Type' => 'application/json' })
    end

    it { is_expected.to be_a(Starling::Resources::AddressesResource) }

    it 'correctly constructs a Addresses resource', :aggregate_failures do
      expect(addresses.current.street_address).to eq('Flat 006')
      expect(addresses.current.city).to eq('LONDON')
      expect(addresses.current.country).to eq('GBR')
      expect(addresses.current.postcode).to eq('SE14 5FA')

      expect(addresses.previous.first.street_address).to eq('Flat 15')
      expect(addresses.previous.first.city).to eq('LONDON')
      expect(addresses.previous.first.country).to eq('GBR')
      expect(addresses.previous.first.postcode).to eq('SE1 7RD')
    end
  end
end
