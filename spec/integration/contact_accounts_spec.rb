require 'spec_helper'

RSpec.describe Starling::Services::ContactAccountsService do
  let(:client) { Starling::Client.new(access_token: 'dummy_access_token') }
  subject(:service) { client.contact_accounts }

  before { stub_user_agent }

  describe '#list' do
    subject(:contact_accounts) { service.list(contact_id) }
    let(:contact_id) { 'ae46414c-7cc4-44f6-8be3-d6a2296f5700' }

    let(:status) { 200 }
    let(:body) { load_fixture('contact_accounts.json') }
    let(:headers) { { 'Content-Type' => 'application/json' } }

    before do
      stub_request(:get,
                   "https://api.starlingbank.com/api/v1/contacts/#{contact_id}/accounts")
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

    it 'correctly constructs Contact Account resources', :aggregate_failures do
      expect(contact_accounts.first).to be_a(Starling::Resources::ContactAccountResource)
      expect(contact_accounts.first.id).to eq('ae46414c-7cc4-44f6-8be3-d6a2296f5700')
      expect(contact_accounts.first.type).to eq(:uk_account_and_sort_code)
      expect(contact_accounts.first.name).to eq('Alice Saunders')
      expect(contact_accounts.first.account_number).to eq('55779911')
      expect(contact_accounts.first.sort_code).to eq('200000')
    end
  end

  describe '#get' do
    subject(:contact_account) { service.get(contact_id, contact_account_id) }

    let(:contact_id) { 'ae46414c-7cc4-44f6-8be3-d6a2296f5700' }
    let(:contact_account_id) { 'ae46414c-7cc4-44f6-8be3-d6a2296f5701' }

    before do
      stub_request(:get,
                   "https://api.starlingbank.com/api/v1/contacts/#{contact_id}/" \
                   "accounts/#{contact_account_id}")
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
      let(:body) { load_fixture('contact_account.json') }
      let(:headers) { { 'Content-Type' => 'application/json' } }

      it { is_expected.to be_a(Starling::Resources::ContactAccountResource) }

      it 'correctly constructs a Contact resource', :aggregate_failures do
        expect(contact_account.id).to eq('ae46414c-7cc4-44f6-8be3-d6a2296f5700')
        expect(contact_account.type).to eq(:uk_account_and_sort_code)
        expect(contact_account.name).to eq('Alice Saunders')
        expect(contact_account.account_number).to eq('55779911')
        expect(contact_account.sort_code).to eq('200000')
      end
    end

    context 'with a non-existent ID' do
      let(:status) { 404 }
      let(:body) { nil }
      let(:headers) { {} }

      it 'raises an error' do
        expect { service.get(contact_id, contact_account_id) }
          .to raise_error(Starling::Errors::ApiError)
      end
    end
  end
end
