require 'spec_helper'

RSpec.describe Starling::Resources::AccountBalanceResource do
  subject(:account_balance) { described_class.new(response: response) }
  let(:fixture) { load_fixture('account_balance.json') }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:accepted_overdraft) { is_expected.to eq(12.34) }
  its(:amount) { is_expected.to eq(12.34) }
  its(:currency) { is_expected.to eq('GBP') }
  its(:pending_transactions) { is_expected.to eq(12.34) }
  its(:cleared_balance) { is_expected.to eq(12.34) }
  its(:effective_balance) { is_expected.to eq(12.34) }
  its(:available_to_spend) { is_expected.to eq(12.34) }
end
