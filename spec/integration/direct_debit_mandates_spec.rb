require 'spec_helper'

RSpec.describe Starling::Services::DirectDebitMandatesService do
  let(:client) { Starling::Client.new(access_token: 'dummy_access_token') }
  subject(:service) { client.direct_debit_mandates }

  before { stub_user_agent }

  describe '#list' do
    subject(:direct_debit_mandates) { service.list }

    let(:status) { 200 }
    let(:body) { load_fixture('direct_debit_mandates.json') }
    let(:headers) { { 'Content-Type' => 'application/json' } }

    before do
      stub_request(:get, 'https://api.starlingbank.com/api/v1/direct-debit/mandates')
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

    it 'correctly constructs Direct Debit Mandate resources', :aggregate_failures do
      expect(direct_debit_mandates.first)
        .to be_a(Starling::Resources::DirectDebitMandateResource)

      expect(direct_debit_mandates.first.uid)
        .to eq('3d69de66-82db-43d1-88a5-c8df24074695')
      expect(direct_debit_mandates.first.reference).to eq('Y8BMVK7')
      expect(direct_debit_mandates.first.status).to eq(:live)
      expect(direct_debit_mandates.first.source).to eq(:electronic)
      expect(direct_debit_mandates.first.created)
        .to eq(Time.parse('2017-05-31T08:07:54.618Z'))
      expect(direct_debit_mandates.first.originator_name).to eq('GC re Tim Rogers')
      expect(direct_debit_mandates.first.originator_uid)
        .to eq('4604224f-c81d-4c34-908b-b9f57fc60d51')
    end
  end

  describe '#get' do
    subject(:direct_debit_mandate) { service.get(id) }

    let(:id) { '3d69de66-82db-43d1-88a5-c8df24074695' }

    before do
      stub_request(:get,
                   "https://api.starlingbank.com/api/v1/direct-debit/mandates/#{id}")
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
      let(:body) { load_fixture('direct_debit_mandate.json') }
      let(:headers) { { 'Content-Type' => 'application/json' } }

      it { is_expected.to be_a(Starling::Resources::DirectDebitMandateResource) }

      it 'correctly constructs a Direct Debit Mandate resource', :aggregate_failures do
        expect(direct_debit_mandate.uid).to eq('3d69de66-82db-43d1-88a5-c8df24074695')
        expect(direct_debit_mandate.reference).to eq('Y8BMVK7')
        expect(direct_debit_mandate.status).to eq(:live)
        expect(direct_debit_mandate.source).to eq(:electronic)
        expect(direct_debit_mandate.created)
          .to eq(Time.parse('2017-05-31T08:07:54.618Z'))
        expect(direct_debit_mandate.originator_name).to eq('GC re Tim Rogers')
        expect(direct_debit_mandate.originator_uid)
          .to eq('4604224f-c81d-4c34-908b-b9f57fc60d51')
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

  describe '#delete' do
    subject { service.delete(id) }

    let(:id) { '3d69de66-82db-43d1-88a5-c8df24074695' }

    before do
      stub_request(:delete,
                   "https://api.starlingbank.com/api/v1/direct-debit/mandates/#{id}")
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
      let(:body) { '' }
      let(:headers) { { 'Content-Type' => 'text/plain' } }

      it { is_expected.to be_a(Faraday::Response) }

      its(:status) { is_expected.to eq(200) }
    end

    context 'with a non-existent ID' do
      let(:status) { 404 }
      let(:body) { nil }
      let(:headers) { {} }

      it 'raises an error' do
        expect { service.delete(id) }.to raise_error(Starling::Errors::ApiError)
      end
    end
  end
end
