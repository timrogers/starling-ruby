require 'spec_helper'

RSpec.describe Starling::Services::ContactsService do
  let(:client) { Starling::Client.new(access_token: 'dummy_access_token') }
  subject(:service) { client.contacts }

  before { stub_user_agent }

  describe '#create' do
    let(:payload) do
      {
        name: 'Alice Saunders',
        accountType: 'domestic',
        accountNumber: '55779911',
        sortCode: '200000'
      }
    end

    subject(:contact) { service.create(params: payload) }

    let(:fixture) { load_fixture('contact.json') }

    context 'with a valid payload' do
      before do
        stub_request(:post, 'https://api.starlingbank.com/api/v1/contacts')
          .with(headers: {
                  'Accept' => 'application/json',
                  'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                  'Authorization' => 'Bearer dummy_access_token',
                  'Content-Type' => 'application/json',
                  'User-Agent' => user_agent
                },
                body: payload.to_json)
          .to_return(status: 202,
                     body: '',
                     headers: {
                       'Content-Type' => 'application/json',
                       'Location' => '/api/v1/contacts/ae46414c-7cc4-44f6-8be3-' \
                                     'd6a2296f5700'
                     })

        stub_request(:get,
                     'https://api.starlingbank.com/api/v1/contacts/' \
                     'ae46414c-7cc4-44f6-8be3-d6a2296f5700')
          .with(headers: {
                  'Accept' => 'application/json',
                  'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                  'Authorization' => 'Bearer dummy_access_token',
                  'User-Agent' => user_agent
                })
          .to_return(status: 200,
                     body: fixture,
                     headers: {
                       'Content-Type' => 'application/json'
                     })
      end

      it { is_expected.to be_a(Starling::Resources::ContactResource) }

      it 'correctly constructs Contact resources', :aggregate_failures do
        expect(contact).to be_a(Starling::Resources::ContactResource)
        expect(contact.name).to eq('Alice Saunders')
      end
    end

    context 'with an invalid payload' do
      before { payload.delete(:accountType) }

      # TODO: Revisit me once the Starling API is fixed so invalid parameters don't blow
      # up with an unhelpful 500.
      before do
        stub_request(:post, 'https://api.starlingbank.com/api/v1/contacts')
          .with(headers: {
                  'Accept' => 'application/json',
                  'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                  'Authorization' => 'Bearer dummy_access_token',
                  'Content-Type' => 'application/json',
                  'User-Agent' => user_agent
                },
                body: payload.to_json)
          .to_return(status: 500,
                     body: '',
                     headers: { 'Content-Type' => 'text/plain' })
      end

      it 'raises an error' do
        expect { service.create(params: payload) }
          .to raise_error(Starling::Errors::ApiError)
      end
    end
  end

  describe '#list' do
    subject(:contacts) { service.list }

    let(:status) { 200 }
    let(:body) { load_fixture('contacts.json') }
    let(:headers) { { 'Content-Type' => 'application/json' } }

    before do
      stub_request(:get, 'https://api.starlingbank.com/api/v1/contacts')
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

    it 'correctly constructs Contact resources', :aggregate_failures do
      expect(contacts.first).to be_a(Starling::Resources::ContactResource)
      expect(contacts.first.id).to eq('e72debff-533d-4a5c-b2ef-210a71a9f601')
      expect(contacts.first.name).to eq('Mr D J Rogers')
    end
  end

  describe '#get' do
    subject(:contact) { service.get(id) }

    let(:id) { 'ae46414c-7cc4-44f6-8be3-d6a2296f5700' }

    before do
      stub_request(:get, "https://api.starlingbank.com/api/v1/contacts/#{id}")
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
      let(:body) { load_fixture('contact.json') }
      let(:headers) { { 'Content-Type' => 'application/json' } }

      it { is_expected.to be_a(Starling::Resources::ContactResource) }

      it 'correctly constructs a Contact resource', :aggregate_failures do
        expect(contact.id).to eq('ae46414c-7cc4-44f6-8be3-d6a2296f5700')
        expect(contact.name).to eq('Alice Saunders')
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

    let(:id) { 'ae46414c-7cc4-44f6-8be3-d6a2296f5700' }

    before do
      stub_request(:delete,
                   "https://api.starlingbank.com/api/v1/contacts/#{id}")
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
