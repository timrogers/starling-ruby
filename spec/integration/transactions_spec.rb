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
    subject(:transactions) { service.list }

    let(:status) { 200 }
    let(:body) { load_fixture('transactions.json') }
    let(:headers) { { 'Content-Type' => 'application/json' } }

    context 'with no filters' do
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

      its(:length) { is_expected.to eq(12) }

      it 'correctly constructs Transaction resources', :aggregate_failures do
        expect(transactions.first.created).to eq(Time.parse('2017-05-30T18:06:28.773Z'))
        expect(transactions.first.id).to eq('ed973200-037d-4f55-9c67-1b467a341203')
        expect(transactions.first.currency).to eq('GBP')
        expect(transactions.first.amount).to eq(-1.02)
        expect(transactions.first.direction).to eq(:outbound)
        expect(transactions.first.narrative).to eq('Aldi')
        expect(transactions.first.source).to eq(:master_card)
      end
    end

    context 'filtering by date' do
      let!(:stub) do
        stub_request(:get,
                     'https://api.starlingbank.com/api/v1/transactions?from=2017-05-30')
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

      it 'adds the provided filter to the URL parameters' do
        service.list(params: { from: '2017-05-30' })
        expect(stub).to have_been_requested
      end
    end
  end

  describe '#get' do
    subject(:transaction) { service.get(id) }

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

      it 'correctly constructs a Transaction resource', :aggregate_failures do
        expect(transaction.created).to eq(Time.parse('2017-05-30T18:06:28.773Z'))
        expect(transaction.id).to eq('284ad156-cb66-465c-8757-f6440304a0f8')
        expect(transaction.currency).to eq('GBP')
        expect(transaction.amount).to eq(-1.02)
        expect(transaction.direction).to eq(:outbound)
        expect(transaction.narrative).to eq('Aldi')
        expect(transaction.source).to eq(:master_card)
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
