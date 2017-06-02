require 'spec_helper'

RSpec.describe Starling::Services::CardService do
  let(:client) { Starling::Client.new(access_token: 'dummy_access_token') }
  subject(:service) { client.card }

  before { stub_user_agent }

  describe '#get' do
    subject(:card) { service.get }

    let(:fixture) { load_fixture('card.json') }

    before do
      stub_request(:get, 'https://api.starlingbank.com/api/v1/cards')
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

    it { is_expected.to be_a(Starling::Resources::CardResource) }

    it 'correctly constructs a Card resource', :aggregate_failures do
      expect(card.id).to eq('2125b5ce-5651-4ebe-9ef9-50b1703508bb')
      expect(card.name_on_card).to eq('Timothy David Rogers')
      expect(card.type).to eq('ContactlessDebitMastercard')
      expect(card.enabled).to be(true)
      expect(card.cancelled).to be(false)
      expect(card.activation_requested).to be(true)
      expect(card.activated).to be(true)
      expect(card.dispatch_date).to eq(Date.new(2017, 5, 19))
    end
  end
end
