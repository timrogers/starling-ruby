require 'spec_helper'

RSpec.describe Starling::Resources::DirectDebitTransactionResource do
  subject(:transaction) { described_class.new(response: response) }
  let(:fixture) { load_fixture('direct_debit_transaction.json') }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:created) { is_expected.to eq(Time.parse('2017-05-31T23:30:00.000Z')) }
  its(:created_at) { is_expected.to eq(Time.parse('2017-05-31T23:30:00.000Z')) }

  its(:id) { is_expected.to eq('7b659a8d-b2a8-4815-9d61-afeb97d4e4b9') }
  its(:currency) { is_expected.to eq('GBP') }
  its(:amount) { is_expected.to eq(-982.21) }
  its(:direction) { is_expected.to eq(:outbound) }
  its(:narrative) { is_expected.to eq('RENDALL AND RITTNER') }
  its(:source) { is_expected.to eq(:direct_debit) }
  its(:mandate_id) { is_expected.to eq('b0fe77e9-7ad1-47a5-ac83-3adf5eb34f4c') }
  its(:type) { is_expected.to eq(:first_payment_of_direct_debit) }
end
