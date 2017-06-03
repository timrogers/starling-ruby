require 'spec_helper'

RSpec.describe Starling::Services::InboundFasterPaymentsTransactionsService do
  let(:client) { Starling::Client.new(access_token: 'dummy_access_token') }
  subject(:service) { client.inbound_faster_payments_transactions }

  before { stub_user_agent }

  describe '#list' do
    subject(:transactions) { service.list }

    let(:status) { 200 }
    let(:body) { load_fixture('inbound_faster_payments_transactions.json') }
    let(:headers) { { 'Content-Type' => 'application/json' } }

    context 'with no filters' do
      before do
        stub_request(:get, 'https://api.starlingbank.com/api/v1/transactions/fps/in')
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

      it 'correctly constructs a Inbound Faster Payments Transaction resources',
         :aggregate_failures do
        expect(transactions.first.created).to eq(Time.parse('2017-05-31T23:54:40.915Z'))
        expect(transactions.first.id).to eq('29a05688-f8a0-49f8-9148-b52a087ee360')
        expect(transactions.first.currency).to eq('GBP')
        expect(transactions.first.amount).to eq(492)
        expect(transactions.first.direction).to eq(:inbound)
        expect(transactions.first.narrative).to eq('sw8 deposit')
        expect(transactions.first.source).to eq(:faster_payments_in)
        expect(transactions.first.sending_contact_id)
          .to eq('ae46414c-7cc4-44f6-8be3-d6a2296f5700')
        expect(transactions.first.sending_contact_account_id)
          .to eq('ae46414c-7cc4-44f6-8be3-d6a2296f5700')
      end
    end

    context 'filtering by date' do
      let!(:stub) do
        stub_request(:get,
                     'https://api.starlingbank.com/api/v1/transactions/fps/in?from=' \
                     '2017-05-30')
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

    let(:id) { '29a05688-f8a0-49f8-9148-b52a087ee360' }

    before do
      stub_request(:get, "https://api.starlingbank.com/api/v1/transactions/fps/in/#{id}")
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
      let(:body) { load_fixture('inbound_faster_payments_transaction.json') }
      let(:headers) { { 'Content-Type' => 'application/json' } }

      it do
        is_expected
          .to be_a(Starling::Resources::InboundFasterPaymentsTransactionResource)
      end

      it 'correctly constructs a Inbound Faster Payments Transaction resources',
         :aggregate_failures do
        expect(transaction.created).to eq(Time.parse('2017-05-31T23:54:40.915Z'))
        expect(transaction.id).to eq('29a05688-f8a0-49f8-9148-b52a087ee360')
        expect(transaction.currency).to eq('GBP')
        expect(transaction.amount).to eq(492)
        expect(transaction.direction).to eq(:inbound)
        expect(transaction.narrative).to eq('sw8 deposit')
        expect(transaction.source).to eq(:faster_payments_in)
        expect(transaction.sending_contact_id)
          .to eq('ae46414c-7cc4-44f6-8be3-d6a2296f5700')
        expect(transaction.sending_contact_account_id)
          .to eq('ae46414c-7cc4-44f6-8be3-d6a2296f5700')
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
