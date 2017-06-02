require 'spec_helper'

RSpec.describe Starling::Services::MeService do
  let(:client) { Starling::Client.new(access_token: 'dummy_access_token') }
  subject(:service) { client.me }

  before { stub_user_agent }

  describe '#get' do
    subject(:me) { service.get }

    let(:fixture) { load_fixture('me.json') }

    before do
      stub_request(:get, 'https://api.starlingbank.com/api/v1/me')
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

    it { is_expected.to be_a(Starling::Resources::MeResource) }

    it 'correctly constructs a Me resource', :aggregate_failures do
      expect(me.customer_uid).to eq('88c4d569-01cc-4217-9bc0-0387b6f7f65d')
      expect(me.authenticated).to be(true)
      expect(me.expires_in_seconds).to eq(0)
      expect(me.scopes).to match(['account:read',
                                  'balance:read',
                                  'address:read',
                                  'address:edit',
                                  'card:read',
                                  'customer:read',
                                  'mandate:read',
                                  'mandate:delete',
                                  'payee:create',
                                  'payee:read',
                                  'transaction:read',
                                  'transaction:edit'])
    end
  end
end
