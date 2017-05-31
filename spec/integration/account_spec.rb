require 'spec_helper'

RSpec.describe Starling::Services::AccountService do
  let(:client) { Starling::Client.new(access_token: 'dummy_access_token') }
  subject(:service) { client.account }

  # The Account Service exposes a nested balance service, as well as being accessible
  # through Client#account_balance
  its(:balance) { is_expected.to be_a(Starling::Services::AccountBalanceService) }

  before do
    allow_any_instance_of(Starling::ApiService).to receive(:user_agent).and_return(
      'starling-ruby/v0.1.0 ruby/2.4.1p111 ruby/2.4.1 x86_64-darwin16 faraday/0.9.2'
    )
  end

  describe '#get' do
    subject(:account) { service.get }

    let(:fixture) { load_fixture('account.json') }

    before do
      stub_request(:get, 'https://api.starlingbank.com/api/v1/accounts')
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

    it { is_expected.to be_a(Starling::Resources::AccountResource) }

    it 'correctly constructs an Account resource', :aggregate_failures do
      expect(account.created_at).to eq(Time.parse('2017-05-17T12:00:00.000Z'))
      expect(account.currency).to eq('GBP')
      expect(account.iban).to eq('GB19SRLG60837199999999')
      expect(account.number).to eq('99999999')
      expect(account.sort_code).to eq('608371')
      expect(account.bic).to eq('SRLGGB2L')
      expect(account.id).to eq('cac60dc8-4448-11e7-a919-92ebcb67fe33')
      expect(account.name).to eq('8d07ea72a-4448-11e7-a919-92ebcb67fe33 GBP')
    end
  end
end
