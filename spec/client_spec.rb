require 'spec_helper'

RSpec.describe Starling::Client do
  FakeResponse = Value.new(:status, :headers, :body)

  subject(:client) { described_class.new(options) }
  let(:options) do
    {
      access_token: 'dummy_access_token',
      connection_options: { request: { timeout: 5 } }
    }
  end

  its(:account) { is_expected.to be_a(Starling::Services::AccountService) }

  its(:account_balance) do
    is_expected.to be_a(Starling::Services::AccountBalanceService)
  end

  its(:transactions) { is_expected.to be_a(Starling::Services::TransactionsService) }
  its(:merchants) { is_expected.to be_a(Starling::Services::MerchantsService) }

  its(:merchant_locations) do
    is_expected.to be_a(Starling::Services::MerchantLocationsService)
  end

  its(:card) { is_expected.to be_a(Starling::Services::CardService) }
  its(:me) { is_expected.to be_a(Starling::Services::MeService) }
  its(:customer) { is_expected.to be_a(Starling::Services::CustomerService) }
  its(:addresses) { is_expected.to be_a(Starling::Services::AddressesService) }

  its(:direct_debit_mandates) do
    is_expected.to be_a(Starling::Services::DirectDebitMandatesService)
  end

  its(:contacts) { is_expected.to be_a(Starling::Services::ContactsService) }

  its(:contact_accounts) do
    is_expected.to be_a(Starling::Services::ContactAccountsService)
  end

  its(:inbound_faster_payments_transactions) do
    is_expected.to be_a(Starling::Services::InboundFasterPaymentsTransactionsService)
  end

  its(:outbound_faster_payments_transactions) do
    is_expected.to be_a(Starling::Services::OutboundFasterPaymentsTransactionsService)
  end

  its(:payments) { is_expected.to be_a(Starling::Services::PaymentsService) }

  its(:mastercard_transactions) do
    is_expected.to be_a(Starling::Services::MastercardTransactionsService)
  end

  it 'instantiates an ApiService, defaulting to production' do
    expect(Starling::ApiService).to receive(:new)
      .with('https://api.starlingbank.com',
            default_headers: {},
            access_token: options[:access_token],
            connection_options: options[:connection_options])

    client
  end

  context 'specifying a non-default environment' do
    before { options[:environment] = :sandbox }

    it 'instantiates an ApiService' do
      expect(Starling::ApiService).to receive(:new)
        .with('https://api-sandbox.starlingbank.com',
              default_headers: {},
              access_token: options[:access_token],
              connection_options: options[:connection_options])

      client
    end
  end

  context 'with no access token' do
    before { options.delete(:access_token) }

    it 'raises an ArgumentError' do
      expect { client }.to raise_error(ArgumentError, /access_token/)
    end
  end

  context 'specifying a non-existent environment' do
    before { options[:environment] = :staging }

    it 'raises an ArgumentError' do
      expect { client }.to raise_error(ArgumentError, /environment/)
    end
  end
end
