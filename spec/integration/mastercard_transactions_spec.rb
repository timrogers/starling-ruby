require 'spec_helper'

RSpec.describe Starling::Services::MastercardTransactionsService do
  let(:client) { Starling::Client.new(access_token: 'dummy_access_token') }
  subject(:service) { client.mastercard_transactions }

  before { stub_user_agent }

  describe '#list' do
    subject(:transactions) { service.list }

    let(:status) { 200 }
    let(:body) { load_fixture('mastercard_transactions.json') }
    let(:headers) { { 'Content-Type' => 'application/json' } }

    context 'with no filters' do
      before do
        stub_request(:get, 'https://api.starlingbank.com/api/v1/transactions/mastercard')
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

      it 'correctly builds an array of Mastercard Transaction resources',
         :aggregate_failures do
        expect(transactions.first.created).to eq(Time.parse('2017-05-31T17:48:02.253Z'))
        expect(transactions.first.id).to eq('3b29c081-e824-4db3-ade4-9deffbd839a2')
        expect(transactions.first.currency).to eq('GBP')
        expect(transactions.first.amount).to eq(-1.5)
        expect(transactions.first.direction).to eq(:outbound)
        expect(transactions.first.narrative).to eq('TFL Travel Charge')
        expect(transactions.first.source).to eq(:master_card)
        expect(transactions.first.mastercard_transaction_method).to eq(:contactless)
        expect(transactions.first.status).to eq(:settled)
        expect(transactions.first.source_amount).to eq(1.5)
        expect(transactions.first.source_currency).to eq('GBP')
        expect(transactions.first.merchant_id)
          .to eq('0a51eab9-5e6b-4572-b9f4-80bbf91f8fbf')
        expect(transactions.first.merchant_location_id)
          .to eq('9fcc6444-9c1d-404c-8f8f-02910a04a102')
      end
    end

    context 'filtering by date' do
      let!(:stub) do
        stub_request(:get,
                     'https://api.starlingbank.com/api/v1/transactions/mastercard?from' \
                     '=2017-05-30')
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
end
