require 'spec_helper'

RSpec.describe Starling::Services::CustomerService do
  let(:client) { Starling::Client.new(access_token: 'dummy_access_token') }
  subject(:service) { client.customer }

  before { stub_user_agent }

  describe '#get' do
    subject(:customer) { service.get }

    let(:fixture) { load_fixture('customer.json') }

    before do
      stub_request(:get, 'https://api.starlingbank.com/api/v1/customers')
        .with(headers: {
                'Accept' => 'application/json',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Authorization' => 'Bearer dummy_access_token',
                'User-Agent' => user_agent
              })
        .to_return(status: 200,
                   body: fixture,
                   headers: { 'Content-Type' => 'application/json' })
    end

    it { is_expected.to be_a(Starling::Resources::CustomerResource) }

    it 'correctly constructs a Customer resource', :aggregate_failures do
      expect(customer.customer_uid).to eq('88c4d569-01cc-4217-9bc0-0387b6f7f65d')
      expect(customer.first_name).to eq('Timothy David')
      expect(customer.last_name).to eq('Rogers')
      expect(customer.date_of_birth).to eq(Date.new(1984, 12, 25))
      expect(customer.email).to eq('me@timrogers.co.uk')
      expect(customer.phone).to eq('+447969999999')
    end
  end
end
