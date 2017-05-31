require 'spec_helper'

RSpec.describe Starling::Services::AccountBalanceService do
  let(:client) { Starling::Client.new(access_token: 'dummy_access_token') }
  subject(:service) { client.account_balance }

  before do
    allow_any_instance_of(Starling::ApiService).to receive(:user_agent).and_return(
      'starling-ruby/v0.1.0 ruby/2.4.1p111 ruby/2.4.1 x86_64-darwin16 faraday/0.9.2'
    )
  end

  describe '#get' do
    subject(:account_balance) { service.get }

    let(:fixture) { load_fixture('account_balance.json') }

    before do
      stub_request(:get, 'https://api.starlingbank.com/api/v1/accounts/balance')
        .with(headers: {
                'Accept' => 'application/json',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Authorization' => 'Bearer dummy_access_token',
                'User-Agent' => 'starling-ruby/v0.1.0 ruby/2.4.1p111 ruby/2.4.1 ' \
                          'x86_64-darwin16 faraday/0.9.2'
              })
        .to_return(status: 200,
                   body: fixture,
                   headers: { 'Content-Type' => 'application/json' })
    end

    it { is_expected.to be_a(Starling::Resources::AccountBalanceResource) }

    it 'correctly constructs an AccountBalance resource', :aggregate_failures do
      expect(account_balance.accepted_overdraft).to eq(12.34)
      expect(account_balance.amount).to eq(12.34)
      expect(account_balance.currency).to eq('GBP')
      expect(account_balance.pending_transactions).to eq(12.34)
      expect(account_balance.cleared_balance).to eq(12.34)
      expect(account_balance.effective_balance).to eq(12.34)
      expect(account_balance.available_to_spend).to eq(12.34)
    end
  end
end
