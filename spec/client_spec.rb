require 'spec_helper'

RSpec.describe Starling::Client do
  FakeResponse = Value.new(:status, :headers, :body)

  subject(:client) { described_class.new(options) }
  let(:options) { { access_token: 'dummy_access_token', custom_options: { x: 'y' } } }

  its(:account) { is_expected.to be_a(Starling::Services::AccountService) }

  its(:account_balance) do
    is_expected.to be_a(Starling::Services::AccountBalanceService)
  end

  its(:transactions) { is_expected.to be_a(Starling::Services::TransactionsService) }

  it 'instantiates an ApiService, defaulting to production' do
    expect(Starling::ApiService).to receive(:new)
      .with('https://api.starlingbank.com', options)

    client
  end

  context 'specifying a non-default environment' do
    before { options[:environment] = :sandbox }

    it 'instantiates an ApiService' do
      expect(Starling::ApiService).to receive(:new)
        .with('https://api-sandbox.starlingbank.com', options)

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
