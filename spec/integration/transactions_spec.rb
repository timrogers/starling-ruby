require 'spec_helper'

RSpec.describe Starling::Services::TransactionsService do
  let(:client) { Starling::Client.new(access_token: 'dummy_access_token') }
  subject(:service) { client.transactions }

  before do
    allow_any_instance_of(Starling::ApiService).to receive(:user_agent).and_return(
      'starling-ruby/v0.1.0 ruby/2.4.1p111 ruby/2.4.1 x86_64-darwin16 faraday/0.9.2'
    )
  end

  describe '#list' do
    subject { service.list }

    before do
      stub_request(:get, 'https://api.starlingbank.com/api/v1/transactions')
        .with(headers: {
                'Accept' => 'application/json',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Authorization' => 'Bearer dummy_access_token',
                'User-Agent' => 'starling-ruby/v0.1.0 ruby/2.4.1p111 ruby/2.4.1 ' \
                          'x86_64-darwin16 faraday/0.9.2'
              })
        .to_return(status: status,
                   body: body,
                   headers: headers)
    end

    let(:status) { 200 }
    let(:body) { load_fixture('transactions.json') }
    let(:headers) { { 'Content-Type' => 'application/json' } }

    its(:length) { is_expected.to eq(12) }

    describe '#first' do
      subject(:transaction) { service.list.first }

      its(:created) { is_expected.to eq(Time.parse('2017-05-30T18:06:28.773Z')) }
      its(:id) { is_expected.to eq('ed973200-037d-4f55-9c67-1b467a341203') }
      its(:currency) { is_expected.to eq('GBP') }
      its(:amount) { is_expected.to eq(-1.02) }
      its(:direction) { is_expected.to eq(:outbound) }
      its(:narrative) { is_expected.to eq('Aldi') }
      its(:source) { is_expected.to eq(:master_card) }
    end
  end

  describe '#get' do
    subject { service.get(id) }

    let(:id) { '284ad156-cb66-465c-8757-f6440304a0f8' }

    before do
      stub_request(:get, "https://api.starlingbank.com/api/v1/transactions/#{id}")
        .with(headers: {
                'Accept' => 'application/json',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Authorization' => 'Bearer dummy_access_token',
                'User-Agent' => 'starling-ruby/v0.1.0 ruby/2.4.1p111 ruby/2.4.1 ' \
                          'x86_64-darwin16 faraday/0.9.2'
              })
        .to_return(status: status,
                   body: body,
                   headers: headers)
    end

    context 'with a valid ID' do
      let(:status) { 200 }
      let(:body) { load_fixture('transaction.json') }
      let(:headers) { { 'Content-Type' => 'application/json' } }

      it { is_expected.to be_a(Starling::Resources::TransactionResource) }

      its(:created) { is_expected.to eq(Time.parse('2017-05-30T18:06:28.773Z')) }
      its(:id) { is_expected.to eq('284ad156-cb66-465c-8757-f6440304a0f8') }
      its(:currency) { is_expected.to eq('GBP') }
      its(:amount) { is_expected.to eq(-1.02) }
      its(:direction) { is_expected.to eq(:outbound) }
      its(:narrative) { is_expected.to eq('Aldi') }
      its(:source) { is_expected.to eq(:master_card) }
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
