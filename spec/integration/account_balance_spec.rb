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
    subject { service.get }

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

    its(:accepted_overdraft) { is_expected.to eq(12.34) }
    its(:amount) { is_expected.to eq(12.34) }
    its(:currency) { is_expected.to eq('GBP') }
    its(:pending_transactions) { is_expected.to eq(12.34) }
    its(:cleared_balance) { is_expected.to eq(12.34) }
    its(:effective_balance) { is_expected.to eq(12.34) }
    its(:available_to_spend) { is_expected.to eq(12.34) }
  end
end
