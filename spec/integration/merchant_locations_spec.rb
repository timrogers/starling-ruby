require 'spec_helper'

RSpec.describe Starling::Services::MerchantLocationsService do
  let(:client) { Starling::Client.new(access_token: 'dummy_access_token') }
  subject(:service) { client.merchant_locations }

  before { stub_user_agent }

  describe '#get' do
    subject(:merchant_location) { service.get(merchant_uid, merchant_location_uid) }

    let(:merchant_uid) { '4cac93d3-f92a-440d-b4f9-fd5bac8368ba' }
    let(:merchant_location_uid) { '10f83832-170f-452a-8b2d-d864de381b37' }

    before do
      stub_request(
        :get,
        "https://api.starlingbank.com/api/v1/merchants/#{merchant_uid}/locations/" \
        "#{merchant_location_uid}"
      )
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

    context 'with valid IDs' do
      let(:status) { 200 }
      let(:body) { load_fixture('merchant_location.json') }
      let(:headers) { { 'Content-Type' => 'application/json' } }

      it { is_expected.to be_a(Starling::Resources::MerchantLocationResource) }

      it 'correctly constructs a MerchantLocation resource', :aggregate_failures do
        expect(merchant_location.merchant_uid)
          .to eq('4cac93d3-f92a-440d-b4f9-fd5bac8368ba')

        expect(merchant_location.merchant_location_uid)
          .to eq('10f83832-170f-452a-8b2d-d864de381b37')

        expect(merchant_location.merchant_name).to eq('Aldi')
        expect(merchant_location.location_name).to eq('ALDI')
        expect(merchant_location.mastercard_merchant_category_code).to eq(5411)
      end
    end

    context 'with non-existent IDs' do
      let(:status) { 404 }
      let(:body) { nil }
      let(:headers) { {} }

      it 'raises an error' do
        expect { service.get(merchant_uid, merchant_location_uid) }
          .to raise_error(Starling::Errors::ApiError)
      end
    end
  end
end
