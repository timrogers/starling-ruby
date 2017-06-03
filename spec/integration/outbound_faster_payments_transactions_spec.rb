require 'spec_helper'

RSpec.describe Starling::Services::OutboundFasterPaymentsTransactionsService do
  let(:client) { Starling::Client.new(access_token: 'dummy_access_token') }
  subject(:service) { client.outbound_faster_payments_transactions }

  before { stub_user_agent }

  describe '#list' do
    subject(:transactions) { service.list }

    let(:status) { 200 }
    let(:body) { load_fixture('outbound_faster_payments_transactions.json') }
    let(:headers) { { 'Content-Type' => 'application/json' } }

    context 'with no filters' do
      before do
        stub_request(:get, 'https://api.starlingbank.com/api/v1/transactions/fps/out')
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

      it 'correctly constructs a Outbound Faster Payments Transaction resources',
         :aggregate_failures do
        expect(transactions.first.created).to eq(Time.parse('2017-05-19T06:28:05.158Z'))
        expect(transactions.first.id).to eq('b7f69386-860f-49b6-9e9d-97b46fefb658')
        expect(transactions.first.currency).to eq('GBP')
        expect(transactions.first.amount).to eq(-15.9)
        expect(transactions.first.direction).to eq(:outbound)
        expect(transactions.first.narrative).to eq('2184EMPH000604')
        expect(transactions.first.source).to eq(:faster_payments_out)
        expect(transactions.first.receiving_contact_id)
          .to eq('7eb7c22e-9a3d-4c25-b4ec-d75a115656ff')
        expect(transactions.first.receiving_contact_account_id)
          .to eq('7eb7c22e-9a3d-4c25-b4ec-d75a115656ff')
      end
    end

    context 'filtering by date' do
      let!(:stub) do
        stub_request(:get,
                     'https://api.starlingbank.com/api/v1/transactions/fps/out?from=' \
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

    let(:id) { 'b7f69386-860f-49b6-9e9d-97b46fefb658' }

    before do
      stub_request(:get,
                   "https://api.starlingbank.com/api/v1/transactions/fps/out/#{id}")
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
      let(:body) { load_fixture('outbound_faster_payments_transaction.json') }
      let(:headers) { { 'Content-Type' => 'application/json' } }

      it do
        is_expected
          .to be_a(Starling::Resources::OutboundFasterPaymentsTransactionResource)
      end

      it 'correctly constructs a Outbound Faster Payments Transaction resources',
         :aggregate_failures do
        expect(transaction.created).to eq(Time.parse('2017-05-19T06:28:05.158Z'))
        expect(transaction.id).to eq('b7f69386-860f-49b6-9e9d-97b46fefb658')
        expect(transaction.currency).to eq('GBP')
        expect(transaction.amount).to eq(-15.9)
        expect(transaction.direction).to eq(:outbound)
        expect(transaction.narrative).to eq('2184EMPH000604')
        expect(transaction.source).to eq(:faster_payments_out)
        expect(transaction.receiving_contact_id)
          .to eq('7eb7c22e-9a3d-4c25-b4ec-d75a115656ff')
        expect(transaction.receiving_contact_account_id)
          .to eq('7eb7c22e-9a3d-4c25-b4ec-d75a115656ff')
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
