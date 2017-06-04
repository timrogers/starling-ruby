require 'spec_helper'

RSpec.describe Starling::Services::DirectDebitTransactionsService do
  let(:client) { Starling::Client.new(access_token: 'dummy_access_token') }
  subject(:service) { client.direct_debit_transactions }

  before { stub_user_agent }

  describe '#list' do
    subject(:transactions) { service.list }

    let(:status) { 200 }
    let(:body) { load_fixture('direct_debit_transactions.json') }
    let(:headers) { { 'Content-Type' => 'application/json' } }

    context 'with no filters' do
      before do
        stub_request(:get,
                     'https://api.starlingbank.com/api/v1/transactions/direct-debit')
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

      its(:length) { is_expected.to eq(2) }

      it 'correctly constructs an array of Direct Debit Transaction resources',
         :aggregate_failures do
        expect(transactions.first.id).to eq('7b659a8d-b2a8-4815-9d61-afeb97d4e4b9')
        expect(transactions.first.currency).to eq('GBP')
        expect(transactions.first.amount).to eq(-982.21)
        expect(transactions.first.direction).to eq(:outbound)
        expect(transactions.first.narrative).to eq('RENDALL AND RITTNER')
        expect(transactions.first.source).to eq(:direct_debit)
        expect(transactions.first.mandate_id)
          .to eq('b0fe77e9-7ad1-47a5-ac83-3adf5eb34f4c')
        expect(transactions.first.type).to eq(:first_payment_of_direct_debit)
      end
    end

    context 'filtering by date' do
      let!(:stub) do
        stub_request(:get,
                     'https://api.starlingbank.com/api/v1/transactions/direct-debit?' \
                     'from=2017-05-30')
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

      it 'adds the provided filter to the URL parameters' do
        service.list(params: { from: '2017-05-30' })
        expect(stub).to have_been_requested
      end
    end
  end

  describe '#get' do
    subject(:transaction) { service.get(id) }

    let(:id) { '7b659a8d-b2a8-4815-9d61-afeb97d4e4b9' }

    before do
      stub_request(:get,
                   "https://api.starlingbank.com/api/v1/transactions/direct-debit/#{id}")
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
      let(:body) { load_fixture('direct_debit_transaction.json') }
      let(:headers) { { 'Content-Type' => 'application/json' } }

      it do
        is_expected
          .to be_a(Starling::Resources::DirectDebitTransactionResource)
      end

      it 'correctly constructs a Direct Debit Transaction resources',
         :aggregate_failures do
        expect(transaction.id).to eq('7b659a8d-b2a8-4815-9d61-afeb97d4e4b9')
        expect(transaction.currency).to eq('GBP')
        expect(transaction.amount).to eq(-982.21)
        expect(transaction.direction).to eq(:outbound)
        expect(transaction.narrative).to eq('RENDALL AND RITTNER')
        expect(transaction.source).to eq(:direct_debit)
        expect(transaction.mandate_id)
          .to eq('b0fe77e9-7ad1-47a5-ac83-3adf5eb34f4c')
        expect(transaction.type).to eq(:first_payment_of_direct_debit)
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
